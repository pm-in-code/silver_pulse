import SwiftUI

struct LobbyView: View {
    @EnvironmentObject var appSession: AppSession
    @StateObject private var quotaViewModel = QuotaViewModel()
    @State private var showingCallView = false
    @State private var showingTimeUpAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Header with Timer
                VStack(spacing: 16) {
                    Text("Silver Pulse")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    // Timer Badge
                    TimerBadge(
                        remainingSeconds: quotaViewModel.remainingSeconds,
                        isTimeLow: quotaViewModel.isTimeLow
                    )
                }
                .padding(.top, 20)
                
                // Coach Card
                if let coach = appSession.selectedCoach {
                    CoachCard(coach: coach)
                        .padding(.horizontal, 24)
                }
                
                Spacer()
                
                // Call Button
                Button(action: startCall) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("CALL")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(appSession.canStartCall ? Color.green : Color.gray)
                    .cornerRadius(12)
                }
                .disabled(!appSession.canStartCall)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
            .background(Color(.systemGray6))
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
                    CoachWebView(coach: coach)
                }
            }
        }
    }
    
    private func startCall() {
        showingCallView = true
    }
}

struct TimerBadge: View {
    let remainingSeconds: Int
    let isTimeLow: Bool
    
    @State private var isAnimating = false
    
    var body: some View {
        HStack {
            Image(systemName: "clock.fill")
            Text(formattedTime)
                .fontWeight(.semibold)
        }
        .font(.body)
        .foregroundColor(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(isTimeLow ? Color.red : Color.accentColor)
        )
        .scaleEffect(isTimeLow && isAnimating ? 1.1 : 1.0)
        .animation(
            isTimeLow ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default,
            value: isAnimating
        )
        .onAppear {
            if isTimeLow {
                isAnimating = true
            }
        }
        .onChange(of: isTimeLow) {
            if isTimeLow {
                isAnimating = true
            } else {
                isAnimating = false
            }
        }
    }
    
    private var formattedTime: String {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct CoachCard: View {
    let coach: Coach
    
    var body: some View {
        VStack(spacing: 20) {
            // Coach Photo
            Image(systemName: "person.fill")
                .font(.system(size: 60))
                .foregroundColor(.accentColor)
                .frame(width: 120, height: 120)
                .background(
                    Circle()
                        .fill(Color(.systemGray5))
                )
                .overlay(
                    Circle()
                        .stroke(Color.accentColor, lineWidth: 4)
                )
            
            // Coach Info
            VStack(spacing: 8) {
                Text(coach.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(coach.tagline)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

#Preview {
    LobbyView()
        .environmentObject(AppSession())
}
