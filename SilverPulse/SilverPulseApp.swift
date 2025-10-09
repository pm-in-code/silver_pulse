import SwiftUI

@main
struct SilverPulseApp: App {
    @StateObject private var appSession = AppSession()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appSession)
                .onAppear {
                    setupAudioSession()
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

