import SwiftUI

struct OnboardingFlowView: View {
    @Binding var isComplete: Bool
    @State private var currentStep = 0
    @State private var selectedMood: Mood?
    @State private var selectedCoach: Coach?
    @State private var dailyReminder = false
    
    @EnvironmentObject var appSession: AppSession
    
    var body: some View {
        NavigationStack {
            Group {
                switch currentStep {
                case 0:
                    AuthView(
                        onContinue: { nextStep() }
                    )
                case 1:
                    VideoOnboardingView(
                        onNext: { nextStep() }
                    )
                case 2:
                    ImageOnboardingIntroView(
                        onNext: { nextStep() }
                    )
                case 3:
                    ImageOnboardingCoachListView(
                        selectedCoach: $selectedCoach,
                        onNext: { nextStep() }
                    )
                case 4:
                    ImageOnboardingReadyView(
                        onNext: { nextStep() }
                    )
                case 5:
                    MoodSelectionView(
                        selectedMood: $selectedMood,
                        dailyReminder: $dailyReminder,
                        onNext: { nextStep() }
                    )
                case 6:
                    MoodConfirmationView(
                        selectedMood: selectedMood,
                        onNext: { nextStep() }
                    )
                case 7:
                    CoachSelectionView(
                        selectedCoach: $selectedCoach,
                        onNext: { nextStep() }
                    )
                case 8:
                    FinalConfirmationView(
                        selectedCoach: selectedCoach,
                        onComplete: { nextStep() }
                    )
                case 9:
                    StoreView(
                        onPurchase: { nextStep() }
                    )
                case 10:
                    PurchaseSuccessView(
                        onStart: { completeOnboarding() }
                    )
                default:
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private func nextStep() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep += 1
        }
    }
    
    private func completeOnboarding() {
        if let mood = selectedMood {
            appSession.selectMood(mood)
        }
        if let coach = selectedCoach {
            appSession.selectCoach(coach)
        }
        appSession.dailyReminder = dailyReminder
        appSession.completeOnboarding()
        
        withAnimation(.easeInOut(duration: 0.5)) {
            isComplete = true
        }
    }
}

#Preview {
    OnboardingFlowView(isComplete: .constant(false))
        .environmentObject(AppSession())
}
