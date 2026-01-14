import SwiftUI
import WebKit
import AVFoundation
import Network
import Combine

struct CoachWebViewOnly: View {
    let coach: Coach
    @Environment(\.dismiss) private var dismiss
    @State private var isNetworkAvailable = true
    @State private var shouldKeepScreenAwake = false
    @State private var networkMonitor: NWPathMonitor?
    @State private var networkQueue = DispatchQueue(label: "NetworkMonitor")
    
    var body: some View {
        ZStack {
            // WebView - только WebView без других элементов
            CallWebViewRepresentable(
                url: buildWebViewURL(),
                onNavigation: handleNavigation
            )
            .background(Color.black)
            .ignoresSafeArea()
        }
        .onAppear {
            setupCall()
        }
        .onDisappear {
            cleanupCall()
        }
    }
    
    private func setupCall() {
        setupAudioSessionForCall()
        setupNetworkMonitoring()
        requestMicrophonePermission()
        
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
                    setKeepScreenAwake(true)
                    // Set call as active when WebView is loaded
                    QuotaService.shared.setCallActive(true)
                }
            )
            .store(in: &cancellables)
        
        // Pause background music for call
        BackgroundMusicService.shared.pauseForCall()
    }
    
    private func cleanupCall() {
        networkMonitor?.cancel()
        setKeepScreenAwake(false)
        
        // Stop call activity before ending call
        QuotaService.shared.setCallActive(false)
        
        // Restore audio session for background music
        restoreAudioSessionAfterCall()
        
        // Resume background music after call
        BackgroundMusicService.shared.resumeAfterCall()
        
        endCall()
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
    
    private func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            Analytics.shared.trackMicrophonePermission(granted)
            if granted {
                print("✅ Microphone permission granted for WebView call")
            } else {
                print("❌ Microphone permission denied for WebView call")
                DispatchQueue.main.async {
                    // Show alert to open settings
                    self.showMicrophonePermissionAlert()
                }
            }
        }
    }
    
    private func showMicrophonePermissionAlert() {
        // This would show an alert to go to settings
        // For now, just log the issue
        print("⚠️ Microphone permission needed for WebView call")
    }
    
    private func buildWebViewURL() -> URL {
        // Use the coach's webURL directly as it already contains all necessary parameters
        return coach.webURL
    }
    
    private func handleNavigation(_ navigation: WKNavigation) {
        // Handle navigation events if needed
    }
    
    private func setupNetworkMonitoring() {
        networkMonitor = NWPathMonitor()
        networkMonitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isNetworkAvailable = path.status == .satisfied
            }
        }
        networkMonitor?.start(queue: networkQueue)
    }
    
    private func setKeepScreenAwake(_ awake: Bool) {
        shouldKeepScreenAwake = awake
        UIApplication.shared.isIdleTimerDisabled = awake
    }
    
    private func setupAudioSessionForCall() {
        do {
            // Configure audio session specifically for WebView calls
            try AVAudioSession.sharedInstance().setCategory(
                .playAndRecord,
                mode: .videoChat,
                options: [.defaultToSpeaker, .allowBluetooth, .allowBluetoothA2DP]
            )
            try AVAudioSession.sharedInstance().setActive(true)
            
            print("✅ Audio session configured for WebView call")
        } catch {
            print("❌ Failed to setup audio session for call: \(error)")
        }
    }
    
    private func restoreAudioSessionAfterCall() {
        do {
            // Restore audio session for background music
            try AVAudioSession.sharedInstance().setCategory(
                .ambient,
                mode: .default,
                options: [.mixWithOthers]
            )
            try AVAudioSession.sharedInstance().setActive(true)
            
            print("✅ Audio session restored for background music")
        } catch {
            print("❌ Failed to restore audio session: \(error)")
        }
    }
    
    @State private var cancellables = Set<AnyCancellable>()
}

struct CallWebViewRepresentable: UIViewRepresentable {
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
        let parent: CallWebViewRepresentable
        
        init(_ parent: CallWebViewRepresentable) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                if url.scheme == "silverpulse" && url.host == "close" {
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Show loading indicator if needed
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.onNavigation(navigation)
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("WebView failed to load: \(error.localizedDescription)")
        }
    }
}
