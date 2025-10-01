import SwiftUI
import WebKit
import AVFoundation

struct CoachWebView: View {
    let coach: Coach
    @Environment(\.dismiss) private var dismiss
    @StateObject private var quotaViewModel = QuotaViewModel()
    @State private var showingEndCallAlert = false
    @State private var showingTimeUpAlert = false
    @State private var backgroundTimer: Timer?
    @State private var backgroundTime: TimeInterval = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with Timer and End Button
            VStack(spacing: 16) {
                // Timer Badge
                TimerBadge(
                    remainingSeconds: quotaViewModel.remainingSeconds,
                    isTimeLow: quotaViewModel.isTimeLow
                )
                
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
            .background(Color.bg)
            
            // WebView
            WebViewRepresentable(
                url: buildWebViewURL(),
                onNavigation: handleNavigation
            )
            .background(Color.black)
        }
        .background(Color.bg)
        .onAppear {
            setupCall()
        }
        .onDisappear {
            cleanupCall()
        }
        .onReceive(NotificationCenter.default.publisher(for: .timeUp)) { _ in
            showingTimeUpAlert = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            startBackgroundTimer()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            stopBackgroundTimer()
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
    
    private func setupCall() {
        requestMicrophonePermission()
        quotaViewModel.refreshQuota()
        
        // Start call session
        QuotaService.shared.startCall(coachId: coach.id)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to start call: \(error)")
                    }
                },
                receiveValue: { session in
                    Analytics.shared.trackCallStart(session)
                }
            )
            .store(in: &cancellables)
    }
    
    private func endCall() {
        QuotaService.shared.stopCall()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to stop call: \(error)")
                    }
                },
                receiveValue: { _ in
                    // Call stopped successfully
                }
            )
            .store(in: &cancellables)
        
        dismiss()
    }
    
    private func cleanupCall() {
        stopBackgroundTimer()
        endCall()
    }
    
    private func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            Analytics.shared.trackMicrophonePermission(granted)
            if !granted {
                DispatchQueue.main.async {
                    // Show alert to open settings
                }
            }
        }
    }
    
    private func buildWebViewURL() -> URL {
        var components = URLComponents(url: coach.webURL, resolvingAgainstBaseURL: false)!
        
        // Add user parameters
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "user_id", value: "17b8ec9b-9a82-49a7-1111-111111111111"),
            URLQueryItem(name: "user_name", value: "John Doe"),
            URLQueryItem(name: "session_id", value: UUID().uuidString),
            URLQueryItem(name: "remaining_seconds", value: "\(quotaViewModel.remainingSeconds)")
        ])
        
        return components.url ?? coach.webURL
    }
    
    private func handleNavigation(_ navigation: WKNavigation) {
        // Handle navigation events if needed
    }
    
    private func startBackgroundTimer() {
        backgroundTime = 0
        backgroundTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            backgroundTime += 1
            if backgroundTime >= 30 { // 30 seconds
                endCall()
            }
        }
    }
    
    private func stopBackgroundTimer() {
        backgroundTimer?.invalidate()
        backgroundTimer = nil
        backgroundTime = 0
    }
    
    private var cancellables = Set<AnyCancellable>()
}

struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    let onNavigation: (WKNavigation) -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = UIColor.black
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebViewRepresentable
        
        init(_ parent: WebViewRepresentable) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                if url.scheme == "silverpulse" && url.host == "close" {
                    // Handle close navigation
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.onNavigation(navigation)
        }
    }
}

#Preview {
    CoachWebView(coach: Coach.allCoaches.first!)
}
