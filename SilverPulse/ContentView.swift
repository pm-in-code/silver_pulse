import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSession: AppSession
    @State private var isOnboardingComplete = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isOnboardingComplete {
                    LobbyView()
                } else {
                    OnboardingFlowView(isComplete: $isOnboardingComplete)
                }
            }
            .onAppear {
                checkOnboardingStatus()
            }
        }
    }
    
    private func checkOnboardingStatus() {
        isOnboardingComplete = appSession.selectedMood != nil && appSession.selectedCoach != nil
    }
}

#Preview {
    ContentView()
        .environmentObject(AppSession())
}

