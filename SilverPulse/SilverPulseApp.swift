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
                            // Start music if not already playing
                            if !backgroundMusic.isPlaying {
                                NSLog("🎵 ContentView appeared - starting music")
                                backgroundMusic.play()
                            }
                        }
                }
            }
        }
    }
    
    private func setupAudioSession() {
        do {
            // Set initial audio session for background music
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            print("✅ Initial audio session configured for background music")
        } catch {
            print("❌ Failed to setup initial audio session: \(error)")
        }
    }
}

import AVFoundation

