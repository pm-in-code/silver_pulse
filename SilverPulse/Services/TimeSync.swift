import Foundation
import Combine

class TimeSync: ObservableObject {
    static let shared = TimeSync()
    
    @Published var timeDrift: TimeInterval = 0
    @Published var isSynced = false
    
    private let apiClient = APIClient.shared
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        syncTime()
    }
    
    func syncTime() {
        let clientTime = Date()
        
        // For mock API, we'll simulate a small drift
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) { [weak self] in
            let serverTime = Date().addingTimeInterval(0.5) // Simulate 500ms server delay
            let drift = serverTime.timeIntervalSince(clientTime)
            
            DispatchQueue.main.async {
                self?.timeDrift = drift
                self?.isSynced = true
            }
        }
    }
    
    func getServerAdjustedTime() -> Date {
        return Date().addingTimeInterval(timeDrift)
    }
    
    func getServerAdjustedTimeInterval(_ interval: TimeInterval) -> TimeInterval {
        return interval + timeDrift
    }
}

