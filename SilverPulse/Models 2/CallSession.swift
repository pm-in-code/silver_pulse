import Foundation

struct CallSession: Codable {
    let id: String
    let coachId: String
    var startedAt: Date
    var remainingSeconds: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "session_id"
        case coachId = "coach_id"
        case startedAt = "started_at"
        case remainingSeconds = "remaining_seconds"
    }
    
    var formattedRemainingTime: String {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var isTimeUp: Bool {
        return remainingSeconds <= 0
    }
}

struct StartCallRequest: Codable {
    let coachId: String
    let clientTimestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case coachId = "coach_id"
        case clientTimestamp = "client_ts"
    }
}

struct StartCallResponse: Codable {
    let sessionId: String
    let remainingSeconds: Int
    let serverTimestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case remainingSeconds = "remaining_seconds"
        case serverTimestamp = "server_timestamp"
    }
}

struct HeartbeatRequest: Codable {
    let sessionId: String
    let elapsedSeconds: Int
    let clientTimestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case elapsedSeconds = "elapsed_seconds"
        case clientTimestamp = "client_ts"
    }
}

struct HeartbeatResponse: Codable {
    let remainingSeconds: Int
    let serverTimestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case remainingSeconds = "remaining_seconds"
        case serverTimestamp = "server_timestamp"
    }
}

struct StopCallRequest: Codable {
    let sessionId: String
    let clientTimestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case clientTimestamp = "client_ts"
    }
}

struct StopCallResponse: Codable {
    let remainingSeconds: Int
    let serverTimestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case remainingSeconds = "remaining_seconds"
        case serverTimestamp = "server_timestamp"
    }
}
