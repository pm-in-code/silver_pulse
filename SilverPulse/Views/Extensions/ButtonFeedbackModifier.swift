import SwiftUI

struct ButtonFeedbackModifier: ViewModifier {
    let feedbackType: FeedbackType
    
    enum FeedbackType {
        case light
        case medium
        case heavy
        case selection
        case success
    }
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                triggerFeedback()
            }
    }
    
    private func triggerFeedback() {
        // Haptic feedback
        switch feedbackType {
        case .light:
            HapticFeedbackService.shared.lightImpact()
        case .medium:
            HapticFeedbackService.shared.mediumImpact()
        case .heavy:
            HapticFeedbackService.shared.heavyImpact()
        case .selection:
            HapticFeedbackService.shared.selectionChanged()
        case .success:
            HapticFeedbackService.shared.notificationSuccess()
        }
        
        // Sound feedback
        SoundEffectsService.shared.playButtonTapSound()
    }
}

// MARK: - Button Extensions

extension View {
    func buttonFeedback(_ type: ButtonFeedbackModifier.FeedbackType = .light) -> some View {
        self.modifier(ButtonFeedbackModifier(feedbackType: type))
    }
}

// MARK: - Custom Button Style with Feedback

struct FeedbackButtonStyle: ButtonStyle {
    let feedbackType: ButtonFeedbackModifier.FeedbackType
    
    init(feedbackType: ButtonFeedbackModifier.FeedbackType = .light) {
        self.feedbackType = feedbackType
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { isPressed in
                if isPressed {
                    // Haptic feedback
                    switch feedbackType {
                    case .light:
                        HapticFeedbackService.shared.lightImpact()
                    case .medium:
                        HapticFeedbackService.shared.mediumImpact()
                    case .heavy:
                        HapticFeedbackService.shared.heavyImpact()
                    case .selection:
                        HapticFeedbackService.shared.selectionChanged()
                    case .success:
                        HapticFeedbackService.shared.notificationSuccess()
                    }
                    
                    // Sound feedback
                    SoundEffectsService.shared.playButtonTapSound()
                }
            }
    }
}
