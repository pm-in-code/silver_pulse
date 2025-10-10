import Foundation
import Combine

class QuotaViewModel: ObservableObject {
    @Published var remainingSeconds = 0
    @Published var isLoading = false
    @Published var error: APIError?
    
    private let quotaService = QuotaService.shared
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    init() {
        setupObservers()
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Public Methods
    
    func refreshQuota() {
        quotaService.fetchQuota()
    }
    
    func startCallTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func stopCallTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private Methods
    
    private func setupObservers() {
        quotaService.$userQuota
            .compactMap { $0?.remainingSeconds }
            .assign(to: \.remainingSeconds, on: self)
            .store(in: &cancellables)
        
        quotaService.$isLoading
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        quotaService.$error
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
        
        // Listen for call timer notifications
        NotificationCenter.default.publisher(for: .callTimerStart)
            .sink { [weak self] _ in
                self?.startCallTimer()
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: .callTimerStop)
            .sink { [weak self] _ in
                self?.stopCallTimer()
            }
            .store(in: &cancellables)
    }
    
    private func startTimer() {
        // Don't start timer automatically - only when call is active
        // Timer will be controlled by QuotaService.isCallActive
    }
    
    private func updateTimer() {
        // Only update if call is currently active
        if quotaService.isCallCurrentlyActive() && remainingSeconds > 0 {
            remainingSeconds -= 1
        }
    }
}

// MARK: - Computed Properties

extension QuotaViewModel {
    var formattedRemainingTime: String {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var isTimeUp: Bool {
        return remainingSeconds <= 0
    }
    
    var isTimeLow: Bool {
        return remainingSeconds <= 300 // 5 minutes
    }
    
    var timeProgress: Double {
        let totalSeconds = 14400 // 4 hours
        return Double(remainingSeconds) / Double(totalSeconds)
    }
}

