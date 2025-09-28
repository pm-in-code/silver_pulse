import SwiftUI
import Combine

struct CoachWebView: View {
    let coach: Coach
    @Environment(\.dismiss) private var dismiss
    @StateObject private var quotaViewModel = QuotaViewModel()
    @State private var showingEndCallAlert = false
    @State private var showingTimeUpAlert = false
    
    var body: some View {
        ZStack {
            // WebView решение
            WebViewContent(
                coach: coach,
                quotaViewModel: quotaViewModel,
                showingEndCallAlert: $showingEndCallAlert,
                showingTimeUpAlert: $showingTimeUpAlert
            )
        }
        .onAppear {
            quotaViewModel.startCallTimer()
        }
        .onDisappear {
            quotaViewModel.stopCallTimer()
        }
        .onReceive(NotificationCenter.default.publisher(for: .timeUp)) { _ in
            showingTimeUpAlert = true
        }
        .alert("Завершить разговор?", isPresented: $showingEndCallAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Завершить", role: .destructive) {
                stopCall()
                dismiss()
            }
        }
        .alert("Время истекло", isPresented: $showingTimeUpAlert) {
            Button("OK") {
                stopCall()
                dismiss()
            }
        } message: {
            Text("Ваше время разговора с коучем истекло.")
        }
    }
    
    private func stopCall() {
        quotaViewModel.stopCallTimer()
    }
}

// MARK: - WebView Content
struct WebViewContent: View {
    let coach: Coach
    @ObservedObject var quotaViewModel: QuotaViewModel
    @Binding var showingEndCallAlert: Bool
    @Binding var showingTimeUpAlert: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with Timer and End Button
            VStack(spacing: 16) {
                // Timer Display
                VStack(spacing: 8) {
                    Text("Время разговора")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(quotaViewModel.formattedRemainingTime)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(quotaViewModel.isTimeLow ? .red : .primary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(quotaViewModel.isTimeLow ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(quotaViewModel.isTimeLow ? Color.red : Color.blue, lineWidth: 1)
                        )
                }
                
                // End Call Button
                Button(action: { showingEndCallAlert = true }) {
                    HStack {
                        Image(systemName: "phone.down.fill")
                        Text("END")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.red)
                    .cornerRadius(20)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 24)
            .background(Color(.systemGray6))
            
            // WebView
            StableWebView(
                url: buildWebViewURL(),
                onNavigation: handleNavigation
            )
            .background(Color.black)
        }
        .background(Color(.systemGray6))
        .onAppear {
            startCall()
        }
        .onDisappear {
            stopCall()
        }
        .onChange(of: quotaViewModel.remainingSeconds) { _, newValue in
            if newValue <= 0 {
                showingTimeUpAlert = true
            }
        }
    }
    
    private func startCall() {
        quotaViewModel.startCallTimer()
    }
    
    private func stopCall() {
        quotaViewModel.stopCallTimer()
    }
    
    private func buildWebViewURL() -> URL {
        let baseURL = "https://voxdiscover-videoclient.vercel.app/"
        let videoURL = "https://segmentvalue.org/silverpulse/\(coach.name.capitalized).mp4"
        let imageURL = "https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/\(coach.name.capitalized).png"
        let animationURL = "https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/\(getAnimationColor()).json"
        
        let parameters = [
            "video": videoURL,
            "id": "17b8ec9b-9a82-49a7-1111-111111111111",
            "name": "John Doe",
            "project": "1",
            "assistant_id": "c7945cb7-4d0e-45a6-91a2-47eb8b080dc3",
            "img_url": imageURL,
            "animation_url": animationURL,
            "user_id": "17b8ec9b-9a82-49a7-1111-111111111111",
            "user_name": "John Doe",
            "session_id": UUID().uuidString,
            "remaining_seconds": "\(quotaViewModel.remainingSeconds)"
        ]
        
        var components = URLComponents(string: baseURL)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url!
    }
    
    private func getAnimationColor() -> String {
        switch coach.name.lowercased() {
        case "laura": return "orange"
        case "matt": return "blue"
        case "james": return "green"
        case "emma": return "purple"
        default: return "orange"
        }
    }
    
    private func handleNavigation(_ navigation: Any) {
        // Handle navigation events if needed
    }
}

// MARK: - Call Timer Badge
struct CallTimerBadge: View {
    let remainingSeconds: Int
    let isTimeLow: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "clock.fill")
                .foregroundColor(isTimeLow ? .red : .white)
            
            Text(formatTime(remainingSeconds))
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(isTimeLow ? .red : .white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(isTimeLow ? Color.red.opacity(0.2) : Color.black.opacity(0.3))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isTimeLow ? Color.red : Color.white.opacity(0.3), lineWidth: 1)
        )
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%02d:%02d", minutes, secs)
        }
    }
}

#Preview {
    CoachWebView(coach: Coach.allCoaches[0])
}