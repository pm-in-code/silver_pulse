import Foundation

struct UserQuota: Codable {
    let totalSeconds: Int
    let usedSeconds: Int
    var remainingSeconds: Int
    let serverTimestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case totalSeconds = "total_seconds"
        case usedSeconds = "used_seconds"
        case remainingSeconds = "remaining_seconds"
        case serverTimestamp = "server_timestamp"
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
