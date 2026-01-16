import SwiftUI

struct LobbyView: View {
    @EnvironmentObject var appSession: AppSession
    @StateObject private var quotaViewModel = QuotaViewModel()
    @State private var showingCallView = false
    @State private var showingTimeUpAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Plan balance: \(formattedTime)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.flowSoftBlue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.top, 24)
                
                Text("Your companion is waiting.\nStart anytime")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                
                if let coach = appSession.selectedCoach {
                    VStack(spacing: 12) {
                        Image(coach.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipped()
                            .cornerRadius(18)
                        
                        Text(coach.name)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                
                Spacer()
                
                Button(action: startCall) {
                    HStack(spacing: 8) {
                        Text("TALK")
                            .font(.headline)
                            .fontWeight(.bold)
                        Image(systemName: "phone.fill")
                    }
                    .foregroundColor(.black)
                    .frame(width: 140, height: 44)
                    .background(appSession.canStartCall ? Color.flowLime : Color.gray)
                    .cornerRadius(22)
                }
                .buttonStyle(FeedbackButtonStyle(feedbackType: .success))
                .disabled(!appSession.canStartCall)
                .padding(.bottom, 32)
            }
            .background(Color.flowLavender)
            .navigationBarHidden(true)
            .onAppear {
                quotaViewModel.refreshQuota()
            }
            .onReceive(NotificationCenter.default.publisher(for: .timeUp)) { _ in
                showingTimeUpAlert = true
            }
            .alert("Time's Up", isPresented: $showingTimeUpAlert) {
                Button("OK") {
                    // Alert dismissed
                }
            } message: {
                Text("Your available time is over for today. See you soon.")
            }
                .fullScreenCover(isPresented: $showingCallView) {
                    if let coach = appSession.selectedCoach {
                        CoachCallView(coach: coach)
                    }
                }
        }
    }
    
    private func startCall() {
        print("🚀 START CALL - remainingSeconds: \(quotaViewModel.remainingSeconds), canStartCall: \(appSession.canStartCall)")
        showingCallView = true
    }
    private var formattedTime: String {
        let hours = quotaViewModel.remainingSeconds / 3600
        let minutes = (quotaViewModel.remainingSeconds % 3600) / 60
        let seconds = quotaViewModel.remainingSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    LobbyView()
        .environmentObject(AppSession())
}
