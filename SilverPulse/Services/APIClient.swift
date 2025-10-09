import Foundation
import Combine

class APIClient: ObservableObject {
    static let shared = APIClient()
    
    private let baseURL = "https://api.silverpulse.com/v1"
    private let session = URLSession.shared
    private var cancellables = Set<AnyCancellable>()
    
    // Mock mode for development
    private let useMockAPI = true
    
    private init() {}
    
    // MARK: - Generic Request Method
    
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod = .GET,
        body: Data? = nil,
        responseType: T.Type
    ) -> AnyPublisher<T, APIError> {
        
        if useMockAPI {
            return mockRequest(endpoint: endpoint, method: method, body: body, responseType: responseType)
        }
        
        guard let url = URL(string: baseURL + endpoint) else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add auth token if available
        if let token = KeychainService.shared.getAuthToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return APIError.decodingError
                } else {
                    return APIError.networkError(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Mock API Implementation
    
    private func mockRequest<T: Codable>(
        endpoint: String,
        method: HTTPMethod,
        body: Data?,
        responseType: T.Type
    ) -> AnyPublisher<T, APIError> {
        
        return Future<T, APIError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                switch endpoint {
                case "/me/quota":
                    if let quota = self.mockUserQuota() as? T {
                        promise(.success(quota))
                    } else {
                        promise(.failure(.decodingError))
                    }
                case "/calls/start":
                    if let response = self.mockStartCallResponse() as? T {
                        promise(.success(response))
                    } else {
                        promise(.failure(.decodingError))
                    }
                case "/calls/heartbeat":
                    if let response = self.mockHeartbeatResponse() as? T {
                        promise(.success(response))
                    } else {
                        promise(.failure(.decodingError))
                    }
                case "/calls/stop":
                    if let response = self.mockStopCallResponse() as? T {
                        promise(.success(response))
                    } else {
                        promise(.failure(.decodingError))
                    }
                default:
                    promise(.failure(.invalidEndpoint))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Mock Data
    
    private var mockRemainingSeconds = 14400 // 4 hours
    
    private func mockUserQuota() -> UserQuota {
        return UserQuota(
            totalSeconds: 14400,
            usedSeconds: 14400 - mockRemainingSeconds,
            remainingSeconds: mockRemainingSeconds,
            serverTimestamp: Date()
        )
    }
    
    private func mockStartCallResponse() -> StartCallResponse {
        return StartCallResponse(
            sessionId: UUID().uuidString,
            remainingSeconds: mockRemainingSeconds,
            serverTimestamp: Date()
        )
    }
    
    private func mockHeartbeatResponse() -> HeartbeatResponse {
        // Decrement time by 15 seconds (heartbeat interval)
        mockRemainingSeconds = max(0, mockRemainingSeconds - 15)
        return HeartbeatResponse(
            remainingSeconds: mockRemainingSeconds,
            serverTimestamp: Date()
        )
    }
    
    private func mockStopCallResponse() -> StopCallResponse {
        return StopCallResponse(
            remainingSeconds: mockRemainingSeconds,
            serverTimestamp: Date()
        )
    }
}

// MARK: - Supporting Types

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidEndpoint
    case networkError(Error)
    case decodingError
    case unauthorized
    case serverError(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to decode response"
        case .unauthorized:
            return "Unauthorized access"
        case .serverError(let code):
            return "Server error: \(code)"
        }
    }
}

