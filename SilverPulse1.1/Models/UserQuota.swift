import Foundation

struct UserQuota: Codable {
    let totalSeconds: Int
    var usedSeconds: Int
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
    
    var formattedUsedTime: String {
        let hours = usedSeconds / 3600
        let minutes = (usedSeconds % 3600) / 60
        let seconds = usedSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var isTimeUp: Bool {
        return remainingSeconds <= 0
    }
    
    // MARK: - Static Methods
    
    static func createInitialQuota() -> UserQuota {
        let totalSeconds = 4 * 3600 // 4 hours
        return UserQuota(
            totalSeconds: totalSeconds,
            usedSeconds: 0,
            remainingSeconds: totalSeconds,
            serverTimestamp: Date()
        )
    }
}
