import AVFoundation
import Combine

class BackgroundMusicService: ObservableObject {
    static let shared = BackgroundMusicService()
    
    @Published var isPlaying = false
    @Published var isMuted = false
    
    private var audioPlayer: AVAudioPlayer?
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        setupAudioSession()
        setupMusic()
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
        // Create a calm, relaxing ambient sound
        let musicData = createAmbientMusic()
        
        do {
            audioPlayer = try AVAudioPlayer(data: musicData)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.volume = 0.2 // Low volume for background
            audioPlayer?.prepareToPlay()
        } catch {
            print("Failed to setup background music: \(error)")
        }
    }
    
    func play() {
        guard !isPlaying else { return }
        
        audioPlayer?.volume = isMuted ? 0.0 : 0.2
        audioPlayer?.play()
        isPlaying = true
        
        print("Background music started")
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
        let sampleRate: Double = 44100
        let duration: Double = 30.0 // 30 seconds loop
        let samples = Int(sampleRate * duration)
        var audioData = Data()
        
        for i in 0..<samples {
            let time = Double(i) / sampleRate
            
            // Create multiple layers of ambient sounds
            var amplitude: Double = 0
            
            // Layer 1: Deep bass tone (very low frequency)
            let bassFreq: Double = 55 // A1
            amplitude += sin(2.0 * .pi * bassFreq * time) * 0.1
            
            // Layer 2: Soft pad sound (mid frequencies)
            let padFreq: Double = 220 // A3
            amplitude += sin(2.0 * .pi * padFreq * time) * 0.05
            
            // Layer 3: High frequency sparkle (very quiet)
            let sparkleFreq: Double = 880 // A5
            amplitude += sin(2.0 * .pi * sparkleFreq * time) * 0.02
            
            // Layer 4: Gentle harmonics
            let harmonicFreq: Double = 330 // E4
            amplitude += sin(2.0 * .pi * harmonicFreq * time) * 0.03
            
            // Add gentle envelope to prevent clicks
            let envelope = 0.5 + 0.5 * sin(2.0 * .pi * time * 0.1) // Very slow modulation
            
            // Apply gentle filtering and reverb-like effect
            let filteredAmplitude = amplitude * envelope * 0.3
            
            let sample = Int16(filteredAmplitude * 16000)
            audioData.append(withUnsafeBytes(of: sample.littleEndian) { Data($0) })
        }
        
        return createWAVData(from: audioData, sampleRate: sampleRate)
    }
    
    private func createWAVData(from audioData: Data, sampleRate: Double) -> Data {
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
        
        return wavData
    }
}

// MARK: - Music Control Extensions

extension BackgroundMusicService {
    func startMusicOnOnboarding() {
        // Start music when user reaches onboarding
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.play()
        }
    }
    
    func pauseForCall() {
        // Pause music when call starts
        pause()
    }
    
    func resumeAfterCall() {
        // Resume music when call ends
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.play()
        }
    }
}
