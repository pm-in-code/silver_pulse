import SwiftUI

struct LobbyView: View {
    @EnvironmentObject var appSession: AppSession
    @StateObject private var quotaViewModel = QuotaViewModel()
    @State private var showingCallView = false
    @State private var showingTimeUpAlert = false
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Header with Timer and Reset Button
                VStack(spacing: 16) {
                    HStack {
                        Text("Silver Pulse")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        // Reset Button
                        Button(action: { showingResetAlert = true }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                // Time Display
                VStack(spacing: 12) {
                    // Remaining Time
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Осталось")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(quotaViewModel.formattedRemainingTime)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(quotaViewModel.isTimeLow ? .red : .primary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Потрачено")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(quotaViewModel.formattedUsedTime)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    // Progress Bar
                    ProgressView(value: quotaViewModel.timeProgress)
                        .progressViewStyle(LinearProgressViewStyle(tint: quotaViewModel.isTimeLow ? .red : .blue))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                }
                }
                .padding(.top, 20)
                .padding(.horizontal, 24)
                
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
                        Text(quotaViewModel.isTimeUp ? "Время истекло" : "Поговорить с коучем")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(quotaViewModel.canStartCall ? Color.blue : Color.gray)
                    .cornerRadius(12)
                }
                .disabled(!quotaViewModel.canStartCall)
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
            .alert("Reset Onboarding", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    appSession.logout()
                }
            } message: {
                Text("This will reset your onboarding and clear your selections. Are you sure?")
            }
            .fullScreenCover(isPresented: $showingCallView) {
                if let coach = appSession.selectedCoach {
                    CoachWebView(coach: coach)
                }
            }
        }
    }
    
        private func startCall() {
            if quotaViewModel.canStartCall {
                showingCallView = true
            }
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
        .onChange(of: isTimeLow) { _, newValue in
            if newValue {
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
            Image(coach.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
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
