import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSession: AppSession
    
    var body: some View {
        NavigationStack {
            Group {
                if appSession.isOnboardingComplete {
                    LobbyView()
                } else {
                    OnboardingFlowView(isComplete: .constant(appSession.isOnboardingComplete))
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppSession())
}