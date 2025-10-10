import SwiftUI

@main
struct SilverPulseApp: App {
    @StateObject private var appSession = AppSession()
    @StateObject private var loadingManager = LoadingScreenManager()
    @StateObject private var backgroundMusic = BackgroundMusicService.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if loadingManager.isLoading {
                    LoadingScreenView()
                        .onAppear {
                            // Simulate loading time
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                loadingManager.finishLoading()
                                // Start background music after loading
                                backgroundMusic.startMusicOnOnboarding()
                            }
                        }
                } else {
                    ContentView()
                        .environmentObject(appSession)
                        .environmentObject(backgroundMusic)
                        .onAppear {
                            setupAudioSession()
                        }
                }
            }
        }
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
}

import AVFoundation

