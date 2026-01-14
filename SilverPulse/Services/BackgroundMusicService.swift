import AVFoundation
import Combine

class BackgroundMusicService: ObservableObject {
    static let shared = BackgroundMusicService()
    
    @Published var isPlaying = false
    @Published var isMuted = false
    
    private var audioPlayer: AVAudioPlayer?
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        print("🎵 Initializing BackgroundMusicService...")
        setupAudioSession()
        setupMusic()
        print("🎵 BackgroundMusicService initialized")
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session for background music: \(error)")
        }
    }
    
    private func setupMusic() {
        print("🎵 Setting up background music...")
        
        // Try to use a simple system sound first for testing
        if let soundURL = Bundle.main.url(forResource: "test_sound", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                print("✅ Using bundled sound file")
            } catch {
                print("❌ Failed to load bundled sound: \(error)")
                setupGeneratedMusic()
            }
        } else {
            print("📝 No bundled sound found, using generated music")
            setupGeneratedMusic()
        }
        
        if let player = audioPlayer {
            player.numberOfLoops = -1 // Loop indefinitely
            player.volume = 0.2 // Low volume for background
            player.prepareToPlay()
            print("✅ Background music audio player configured successfully")
        }
    }
    
    private func setupGeneratedMusic() {
        // Create a calm, relaxing ambient sound
        let musicData = createAmbientMusic()
        NSLog("🎵 Created ambient music data: %lu bytes", musicData.count)
        print("🎵 Created ambient music data: \(musicData.count) bytes")
        
        do {
            audioPlayer = try AVAudioPlayer(data: musicData)
            if let player = audioPlayer {
                NSLog("✅ Generated music audio player created - duration: %f seconds", player.duration)
                print("✅ Generated music audio player created - duration: \(player.duration) seconds")
            }
        } catch {
            NSLog("❌ Failed to setup generated background music: %@", error.localizedDescription)
            print("❌ Failed to setup generated background music: \(error)")
        }
    }
    
    func play() {
        NSLog("🎵 play() called - isPlaying: %d", isPlaying)
        
        guard !isPlaying else { 
            NSLog("🎵 Background music already playing, skipping")
            print("🎵 Background music already playing, skipping")
            return 
        }
        
        guard let player = audioPlayer else {
            NSLog("❌ No audio player available for background music")
            print("❌ No audio player available for background music")
            return
        }
        
        // Check audio session
        let session = AVAudioSession.sharedInstance()
        NSLog("🎵 Audio session category: %@", session.category.rawValue)
        NSLog("🎵 Audio session mode: %@", session.mode.rawValue)
        print("🎵 Audio session category: \(session.category.rawValue)")
        print("🎵 Audio session mode: \(session.mode.rawValue)")
        print("🎵 Audio session is active: \(session.isOtherAudioPlaying)")
        
        player.volume = isMuted ? 0.0 : 0.2
        NSLog("🎵 Attempting to play with volume: %f", player.volume)
        print("🎵 Attempting to play with volume: \(player.volume)")
        
        let success = player.play()
        isPlaying = true
        
        if success {
            NSLog("✅ Background music started successfully")
            print("✅ Background music started successfully")
        } else {
            NSLog("❌ Failed to start background music - play() returned false")
            print("❌ Failed to start background music - play() returned false")
            isPlaying = false
        }
    }
    
    func pause() {
        guard isPlaying else { return }
        
        audioPlayer?.pause()
        isPlaying = false
        
        print("Background music paused")
    }
    
    func stop() {
        audioPlayer?.stop()
        isPlaying = false
        
        print("Background music stopped")
    }
    
    func setMuted(_ muted: Bool) {
        isMuted = muted
        audioPlayer?.volume = muted ? 0.0 : 0.2
        
        print("Background music muted: \(muted)")
    }
    
    // MARK: - Music Generation
    
    private func createAmbientMusic() -> Data {
        print("🎵 Creating peaceful ambient soundscape...")
        let sampleRate: Double = 44100
        let duration: Double = 20.0 // 20 seconds loop
        let samples = Int(sampleRate * duration)
        var audioData = Data()
        audioData.reserveCapacity(samples * 2)
        
        for i in 0..<samples {
            let time = Double(i) / sampleRate
            var amplitude: Double = 0
            
            // Deep sub-bass drone (creates warm foundation)
            amplitude += sin(2.0 * .pi * 55.0 * time) * 0.08  // A1
            
            // Bass harmony (gentle movement)
            let bassModulation = sin(2.0 * .pi * 0.03 * time) // Very slow 0.03 Hz
            amplitude += sin(2.0 * .pi * 110.0 * time) * (0.10 + 0.02 * bassModulation)  // A2
            
            // Mid-range pad (creates richness)
            amplitude += sin(2.0 * .pi * 220.0 * time) * 0.06   // A3
            amplitude += sin(2.0 * .pi * 261.63 * time) * 0.05  // C4
            amplitude += sin(2.0 * .pi * 329.63 * time) * 0.04  // E4
            
            // High frequencies (air and space)
            let shimmer = sin(2.0 * .pi * 0.07 * time) // Slow shimmer
            amplitude += sin(2.0 * .pi * 440.0 * time) * (0.02 + 0.01 * shimmer)   // A4
            amplitude += sin(2.0 * .pi * 523.25 * time) * (0.015 + 0.005 * shimmer) // C5
            
            // Very subtle high sparkle
            let twinkle = abs(sin(2.0 * .pi * 0.13 * time)) // Gentle twinkling
            amplitude += sin(2.0 * .pi * 880.0 * time) * 0.008 * twinkle  // A5
            
            // Gentle global LFO for breathing effect
            let breathe = 0.75 + 0.25 * sin(2.0 * .pi * 0.05 * time)
            amplitude *= breathe
            
            // Smooth crossfade at loop points
            let fadeTime: Double = 1.0
            var envelope: Double = 1.0
            if time < fadeTime {
                envelope = 0.5 * (1.0 - cos(.pi * time / fadeTime))
            } else if time > duration - fadeTime {
                envelope = 0.5 * (1.0 + cos(.pi * (time - (duration - fadeTime)) / fadeTime))
            }
            amplitude *= envelope
            
            // Comfortable volume
            let sample = Int16(amplitude * 6000)
            audioData.append(withUnsafeBytes(of: sample.littleEndian) { Data($0) })
        }
        
        let wavData = createWAVData(from: audioData, sampleRate: sampleRate)
        print("🎵 Created ambient soundscape: \(wavData.count) bytes (\(duration)s loop)")
        return wavData
    }
    
    private func createWAVData(from audioData: Data, sampleRate: Double) -> Data {
        print("🎵 Creating WAV data from \(audioData.count) audio bytes...")
        var wavData = Data()
        
        // WAV header
        wavData.append("RIFF".data(using: .ascii)!)
        wavData.append(withUnsafeBytes(of: UInt32(36 + audioData.count).littleEndian) { Data($0) })
        wavData.append("WAVE".data(using: .ascii)!)
        wavData.append("fmt ".data(using: .ascii)!)
        wavData.append(withUnsafeBytes(of: UInt32(16).littleEndian) { Data($0) }) // fmt chunk size
        wavData.append(withUnsafeBytes(of: UInt16(1).littleEndian) { Data($0) }) // PCM format
        wavData.append(withUnsafeBytes(of: UInt16(1).littleEndian) { Data($0) }) // channels
        wavData.append(withUnsafeBytes(of: UInt32(sampleRate).littleEndian) { Data($0) }) // sample rate
        wavData.append(withUnsafeBytes(of: UInt32(sampleRate * 2).littleEndian) { Data($0) }) // byte rate
        wavData.append(withUnsafeBytes(of: UInt16(2).littleEndian) { Data($0) }) // block align
        wavData.append(withUnsafeBytes(of: UInt16(16).littleEndian) { Data($0) }) // bits per sample
        wavData.append("data".data(using: .ascii)!)
        wavData.append(withUnsafeBytes(of: UInt32(audioData.count).littleEndian) { Data($0) })
        wavData.append(audioData)
        
        print("🎵 WAV data created: \(wavData.count) total bytes")
        return wavData
    }
}

// MARK: - Music Control Extensions

extension BackgroundMusicService {
    func startMusicOnOnboarding() {
        NSLog("🎵 Starting music on onboarding...")
        print("🎵 Starting music on onboarding...")
        // Start music when user reaches onboarding
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            NSLog("🎵 Attempting to play background music...")
            print("🎵 Attempting to play background music...")
            self.play()
        }
    }
    
    func pauseForCall() {
        // Pause music when call starts
        pause()
        print("Background music paused for call")
    }
    
    func resumeAfterCall() {
        // Restore audio session for background music
        setupAudioSession()
        
        // Resume music when call ends
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.play()
        }
        
        print("Background music will resume after call")
    }
}
