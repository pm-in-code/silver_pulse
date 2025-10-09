import Foundation

class Analytics {
    static let shared = Analytics()
    
    private init() {}
    
    // MARK: - Onboarding Events
    
    func trackMoodSelected(_ mood: Mood) {
        logEvent("[Onboarding] Mood_Selected", parameters: [
            "mood_id": mood.id,
            "mood_title": mood.title
        ])
    }
    
    func trackCoachSelected(_ coach: Coach) {
        logEvent("[Onboarding] Coach_Selected", parameters: [
            "coach_id": coach.id,
            "coach_name": coach.name
        ])
    }
    
    
    // MARK: - Permission Events
    
    func trackMicrophonePermission(_ granted: Bool) {
        logEvent("[Permissions] Mic_\(granted ? "Allowed" : "Denied")")
    }
    
    // MARK: - Private Methods
    
    private func logEvent(_ eventName: String, parameters: [String: Any] = [:]) {
        // In a real app, you would send this to your analytics service
        // Examples: Firebase Analytics, Mixpanel, Amplitude, etc.
    }
}
