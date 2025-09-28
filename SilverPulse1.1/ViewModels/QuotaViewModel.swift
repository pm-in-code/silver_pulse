import Foundation
import Combine
import UIKit

class QuotaViewModel: ObservableObject {
    @Published var remainingSeconds = 0
    @Published var usedSeconds = 0
    @Published var isLoading = false
    @Published var error: APIError?
    @Published var isCallActive = false
    
    private let quotaService = QuotaService.shared
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    private var backgroundTime: Date?
    
    init() {
        setupObservers()
        setupBackgroundObservers()
        // Не запускаем таймер автоматически
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Public Methods
    
    func refreshQuota() {
        quotaService.fetchQuota()
    }
    
    func startCallTimer() {
        isCallActive = true
        startTimer()
    }
    
    func stopCallTimer() {
        isCallActive = false
        stopTimer()
    }
    
    // MARK: - Private Methods
    
    private func setupObservers() {
        quotaService.$userQuota
            .compactMap { $0?.remainingSeconds }
            .assign(to: \.remainingSeconds, on: self)
            .store(in: &cancellables)
        
        quotaService.$userQuota
            .compactMap { $0?.usedSeconds }
            .assign(to: \.usedSeconds, on: self)
            .store(in: &cancellables)
        
        quotaService.$isLoading
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        quotaService.$error
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
    }
    
    private func setupBackgroundObservers() {
        // Обработка перехода в фон и возврата
        NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .sink { [weak self] _ in
                self?.handleAppWillResignActive()
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.handleAppDidBecomeActive()
            }
            .store(in: &cancellables)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimer() {
        // Таймер работает только во время активного разговора
        if isCallActive && remainingSeconds > 0 {
            remainingSeconds -= 1
            usedSeconds += 1
            
            // Обновляем в сервисе
            quotaService.updateRemainingTime(remainingSeconds)
            quotaService.updateUsedTime(usedSeconds)
            
            // Если время закончилось, останавливаем таймер
            if remainingSeconds <= 0 {
                stopCallTimer()
                NotificationCenter.default.post(name: .timeUp, object: nil)
            }
        }
    }
    
    private func handleAppWillResignActive() {
        // Приложение уходит в фон - останавливаем таймер
        if isCallActive {
            backgroundTime = Date()
            stopTimer()
        }
    }
    
    private func handleAppDidBecomeActive() {
        // Приложение вернулось из фона
        if isCallActive {
            // Восстанавливаем таймер после возврата из фона
            startTimer()
            self.backgroundTime = nil
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
    
    var formattedUsedTime: String {
        let hours = usedSeconds / 3600
        let minutes = (usedSeconds % 3600) / 60
        let seconds = usedSeconds % 60
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
    
    var canStartCall: Bool {
        return !isTimeUp && !isCallActive
    }
}
