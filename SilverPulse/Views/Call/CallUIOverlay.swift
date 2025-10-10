import SwiftUI

struct CallUIOverlay: View {
    let coach: Coach
    @Environment(\.dismiss) private var dismiss
    @StateObject private var quotaViewModel = QuotaViewModel()
    @State private var showingEndCallAlert = false
    @State private var showingTimeUpAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with Timer and End Button
            VStack(spacing: 20) {
                // Coach name
                Text(coach.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 8)
                
                // Timer Badge
                CallTimerBadge(
                    remainingSeconds: quotaViewModel.remainingSeconds,
                    isTimeLow: quotaViewModel.isTimeLow
                )
                
                // End Call Button
                Button(action: { showingEndCallAlert = true }) {
                    HStack(spacing: 8) {
                        Image(systemName: "phone.down.fill")
                            .font(.system(size: 16, weight: .semibold))
                        Text("End Call")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.red.opacity(0.8), Color.red]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(25)
                    .shadow(color: Color.red.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(FeedbackButtonStyle(feedbackType: .heavy))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
            
            Spacer()
        }
        .onAppear {
            quotaViewModel.refreshQuota()
        }
        .onReceive(NotificationCenter.default.publisher(for: .timeUp)) { _ in
            showingTimeUpAlert = true
        }
        .alert("End Call", isPresented: $showingEndCallAlert) {
            Button("Cancel", role: .cancel) { }
            Button("End Call", role: .destructive) {
                endCall()
            }
        } message: {
            Text("Are you sure you want to end this call?")
        }
        .alert("Time's Up", isPresented: $showingTimeUpAlert) {
            Button("OK") {
                endCall()
            }
        } message: {
            Text("Your available time is over for today. See you soon.")
        }
    }
    
    private func endCall() {
        // This will trigger the WebView to close through the parent view
        dismiss()
    }
}

struct CallTimerBadge: View {
    let remainingSeconds: Int
    let isTimeLow: Bool
    
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "clock.fill")
                .font(.system(size: 16, weight: .medium))
            Text(formattedTime)
                .font(.system(.body, design: .monospaced))
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: isTimeLow ? 
                            [Color.red.opacity(0.8), Color.red] : 
                            [Color.blue.opacity(0.8), Color.blue]
                        ),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: (isTimeLow ? Color.red : Color.blue).opacity(0.3), radius: 6, x: 0, y: 3)
        )
        .scaleEffect(isTimeLow && isAnimating ? 1.05 : 1.0)
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

#Preview {
    CallUIOverlay(coach: Coach.allCoaches[0])
}
