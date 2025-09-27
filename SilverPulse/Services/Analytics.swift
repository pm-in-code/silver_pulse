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
    
    // MARK: - Call Events
    
    func trackCallStart(_ session: CallSession) {
        logEvent("[Call] Start", parameters: [
            "session_id": session.id,
            "coach_id": session.coachId,
            "remaining_seconds": session.remainingSeconds
        ])
    }
    
    func trackCallHeartbeat(_ session: CallSession) {
        logEvent("[Call] Heartbeat", parameters: [
            "session_id": session.id,
            "remaining_seconds": session.remainingSeconds
        ])
    }
    
    func trackCallStop(_ session: CallSession) {
        logEvent("[Call] Stop", parameters: [
            "session_id": session.id,
            "remaining_seconds": session.remainingSeconds
        ])
    }
    
    func trackTimeExceeded(_ session: CallSession) {
        logEvent("[Call] Time_Exceeded", parameters: [
            "session_id": session.id,
            "coach_id": session.coachId
        ])
    }
    
    // MARK: - Permission Events
    
    func trackMicrophonePermission(_ granted: Bool) {
        logEvent("[Permissions] Mic_\(granted ? "Allowed" : "Denied")")
    }
    
    // MARK: - Private Methods
    
    private func logEvent(_ eventName: String, parameters: [String: Any] = [:]) {
        print("📊 Analytics: \(eventName)")
        if !parameters.isEmpty {
            print("   Parameters: \(parameters)")
        }
        
        // In a real app, you would send this to your analytics service
        // Examples: Firebase Analytics, Mixpanel, Amplitude, etc.
    }
}
