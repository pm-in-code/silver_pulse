import Foundation
import Combine

class QuotaService: ObservableObject {
    static let shared = QuotaService()
    
    @Published var userQuota: UserQuota?
    @Published var isLoading = false
    @Published var error: APIError?
    
    private let apiClient = APIClient.shared
    private var cancellables = Set<AnyCancellable>()
    private var heartbeatTimer: Timer?
    private var currentSession: CallSession?
    private var isCallActive = false
    
    private init() {}
    
    // MARK: - Public Methods
    
    func fetchQuota() {
        isLoading = true
        error = nil
        
        apiClient.request(
            endpoint: "/me/quota",
            method: .GET,
            responseType: UserQuota.self
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            },
            receiveValue: { [weak self] quota in
                self?.userQuota = quota
            }
        )
        .store(in: &cancellables)
    }
    
    func startCall(coachId: String) -> AnyPublisher<CallSession, APIError> {
        let request = StartCallRequest(
            coachId: coachId,
            clientTimestamp: Date()
        )
        
        guard let body = try? JSONEncoder().encode(request) else {
            return Fail(error: APIError.decodingError)
                .eraseToAnyPublisher()
        }
        
        return apiClient.request(
            endpoint: "/calls/start",
            method: .POST,
            body: body,
            responseType: StartCallResponse.self
        )
        .map { response in
            let session = CallSession(
                id: response.sessionId,
                coachId: coachId,
                startedAt: Date(),
                remainingSeconds: response.remainingSeconds
            )
            self.currentSession = session
            // Don't start heartbeat automatically - wait for setCallActive(true)
            return session
        }
        .eraseToAnyPublisher()
    }
    
    func stopCall() -> AnyPublisher<StopCallResponse, APIError> {
        guard let session = currentSession else {
            return Fail(error: APIError.invalidEndpoint)
                .eraseToAnyPublisher()
        }
        
        stopHeartbeat()
        
        let request = StopCallRequest(
            sessionId: session.id,
            clientTimestamp: Date()
        )
        
        guard let body = try? JSONEncoder().encode(request) else {
            return Fail(error: APIError.decodingError)
                .eraseToAnyPublisher()
        }
        
        return apiClient.request(
            endpoint: "/calls/stop",
            method: .POST,
            body: body,
            responseType: StopCallResponse.self
        )
        .map { response in
            self.currentSession = nil
            self.isCallActive = false
            self.userQuota?.remainingSeconds = response.remainingSeconds
            return response
        }
        .eraseToAnyPublisher()
    }
    
    func updateRemainingTime(_ seconds: Int) {
        userQuota?.remainingSeconds = seconds
        currentSession?.remainingSeconds = seconds
    }
    
    func setCallActive(_ active: Bool) {
        isCallActive = active
        if active {
            startHeartbeat()
            // Notify that call timer should start
            NotificationCenter.default.post(name: .callTimerStart, object: nil)
        } else {
            stopHeartbeat()
            // Notify that call timer should stop
            NotificationCenter.default.post(name: .callTimerStop, object: nil)
        }
    }
    
    func isCallCurrentlyActive() -> Bool {
        return isCallActive
    }
    
    // MARK: - Private Methods
    
    private func startHeartbeat() {
        // Only start if not already active and call is active
        guard isCallActive, heartbeatTimer == nil else { return }
        heartbeatTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { [weak self] _ in
            self?.sendHeartbeat()
        }
    }
    
    private func stopHeartbeat() {
        heartbeatTimer?.invalidate()
        heartbeatTimer = nil
    }
    
    private func sendHeartbeat() {
        guard let session = currentSession, isCallActive else { return }
        
        let elapsedSeconds = Int(Date().timeIntervalSince(session.startedAt))
        let request = HeartbeatRequest(
            sessionId: session.id,
            elapsedSeconds: elapsedSeconds,
            clientTimestamp: Date()
        )
        
        guard let body = try? JSONEncoder().encode(request) else { return }
        
        apiClient.request(
            endpoint: "/calls/heartbeat",
            method: .POST,
            body: body,
            responseType: HeartbeatResponse.self
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] response in
                self?.updateRemainingTime(response.remainingSeconds)
                
                // Check if time is up
                if response.remainingSeconds <= 0 {
                    self?.handleTimeUp()
                }
            }
        )
        .store(in: &cancellables)
    }
    
    private func handleTimeUp() {
        stopHeartbeat()
        currentSession = nil
        isCallActive = false
        
        // Post notification for UI to handle
        NotificationCenter.default.post(
            name: .timeUp,
            object: nil
        )
    }
}

// MARK: - Notifications

extension Notification.Name {
    static let timeUp = Notification.Name("timeUp")
    static let callTimerStart = Notification.Name("callTimerStart")
    static let callTimerStop = Notification.Name("callTimerStop")
}

