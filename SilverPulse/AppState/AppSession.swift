import Foundation
import SwiftUI
import Combine

class AppSession: ObservableObject {
    @Published var selectedMood: Mood?
    @Published var selectedCoach: Coach?
    @Published var isAuthenticated = false
    @Published var remainingSeconds = 0
    
    // Services
    let quotaService = QuotaService.shared
    let timeSync = TimeSync.shared
    let analytics = Analytics.shared
    
    // User preferences
    @AppStorage("daily_reminder") var dailyReminder = false
    @AppStorage("selected_mood_id") private var selectedMoodId: String = ""
    @AppStorage("selected_coach_id") private var selectedCoachId: String = ""
    @AppStorage("last_remaining_seconds") private var lastRemainingSeconds: Int = 0
    
    init() {
        loadUserPreferences()
        setupObservers()
    }
    
    // MARK: - Public Methods
    
    func selectMood(_ mood: Mood) {
        selectedMood = mood
        selectedMoodId = mood.id
        analytics.trackMoodSelected(mood)
    }
    
    func selectCoach(_ coach: Coach) {
        selectedCoach = coach
        selectedCoachId = coach.id
        analytics.trackCoachSelected(coach)
    }
    
    func completeOnboarding() {
        // Mark onboarding as complete
        UserDefaults.standard.set(true, forKey: "onboarding_complete")
    }
    
    func refreshQuota() {
        quotaService.fetchQuota()
    }
    
    func logout() {
        selectedMood = nil
        selectedCoach = nil
        selectedMoodId = ""
        selectedCoachId = ""
        isAuthenticated = false
        remainingSeconds = 0
        
        // Clear keychain
        KeychainService.shared.deleteAuthToken()
        
        // Reset onboarding
        UserDefaults.standard.set(false, forKey: "onboarding_complete")
    }
    
    // MARK: - Private Methods
    
    private func loadUserPreferences() {
        // Load selected mood
        if !selectedMoodId.isEmpty {
            selectedMood = Mood.allMoods.first { $0.id == selectedMoodId }
        }
        
        // Load selected coach
        if !selectedCoachId.isEmpty {
            selectedCoach = Coach.allCoaches.first { $0.id == selectedCoachId }
        }
        
        // Load last remaining seconds
        remainingSeconds = lastRemainingSeconds
        
        // Check authentication status
        isAuthenticated = KeychainService.shared.getAuthToken() != nil
    }
    
    private func setupObservers() {
        // Observe quota changes
        quotaService.$userQuota
            .compactMap { $0?.remainingSeconds }
            .assign(to: \.remainingSeconds, on: self)
            .store(in: &cancellables)
        
        // Save remaining seconds when it changes
        $remainingSeconds
            .receive(on: DispatchQueue.main)
            .sink { [weak self] seconds in
                self?.lastRemainingSeconds = seconds
            }
            .store(in: &cancellables)
        
        // Observe time up notifications
        NotificationCenter.default.publisher(for: .timeUp)
            .sink { [weak self] _ in
                self?.handleTimeUp()
            }
            .store(in: &cancellables)
    }
    
    private func handleTimeUp() {
        // Show alert and navigate back to lobby
        DispatchQueue.main.async {
            // This will be handled by the UI layer
            print("Time's up! Session ended.")
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - Computed Properties

extension AppSession {
    var isOnboardingComplete: Bool {
        return selectedMood != nil && selectedCoach != nil
    }
    
    var canStartCall: Bool {
        return remainingSeconds > 0 && selectedCoach != nil
    }
    
    var formattedRemainingTime: String {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var isTimeLow: Bool {
        return remainingSeconds <= 300 // 5 minutes
    }
}
