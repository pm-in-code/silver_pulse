import Foundation
import Combine

class QuotaService: ObservableObject {
    static let shared = QuotaService()
    
    @Published var userQuota: UserQuota?
    @Published var isLoading = false
    @Published var error: APIError?
    
    private let apiClient = APIClient.shared
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Persistence Keys
    private let quotaKey = "user_quota"
    private let isFirstLaunchKey = "is_first_launch"
    
    private init() {
        loadQuotaFromStorage()
    }
    
    // MARK: - Public Methods
    
    func fetchQuota() {
        // Для локального приложения используем сохраненные данные
        loadQuotaFromStorage()
    }
    
    func updateRemainingTime(_ seconds: Int) {
        DispatchQueue.main.async {
            self.userQuota?.remainingSeconds = max(0, seconds)
            self.saveQuotaToStorage()
        }
    }
    
    func updateUsedTime(_ seconds: Int) {
        DispatchQueue.main.async {
            guard var quota = self.userQuota else { return }
            quota.usedSeconds = seconds
            quota.remainingSeconds = quota.totalSeconds - seconds
            self.userQuota = quota
            self.saveQuotaToStorage()
        }
    }
    
    func resetQuota() {
        DispatchQueue.main.async {
            self.userQuota = UserQuota.createInitialQuota()
            self.saveQuotaToStorage()
        }
    }
    
    // MARK: - Private Methods
    
    private func loadQuotaFromStorage() {
        // Проверяем, первый ли это запуск
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: isFirstLaunchKey)
        
        if isFirstLaunch {
            // Первый запуск - создаем начальную квоту
            userQuota = UserQuota.createInitialQuota()
            saveQuotaToStorage()
            UserDefaults.standard.set(true, forKey: isFirstLaunchKey)
        } else {
            // Загружаем сохраненную квоту
            if let data = UserDefaults.standard.data(forKey: quotaKey),
               let quota = try? JSONDecoder().decode(UserQuota.self, from: data) {
                userQuota = quota
            } else {
                // Если не удалось загрузить, создаем новую
                userQuota = UserQuota.createInitialQuota()
                saveQuotaToStorage()
            }
        }
    }
    
    private func saveQuotaToStorage() {
        guard let quota = userQuota,
              let data = try? JSONEncoder().encode(quota) else { return }
        UserDefaults.standard.set(data, forKey: quotaKey)
    }
}

// MARK: - Notifications

extension Notification.Name {
    static let timeUp = Notification.Name("timeUp")
}
