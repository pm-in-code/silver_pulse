import UIKit
import AVFoundation

class HapticFeedbackService {
    static let shared = HapticFeedbackService()
    
    private init() {}
    
    // MARK: - Vibration Feedback
    
    func lightImpact() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    func mediumImpact() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    func heavyImpact() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
    }
    
    func selectionChanged() {
        let selectionFeedback = UISelectionFeedbackGenerator()
        selectionFeedback.selectionChanged()
    }
    
    func notificationSuccess() {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.success)
    }
    
    func notificationWarning() {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.warning)
    }
    
    func notificationError() {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.error)
    }
}

// MARK: - Sound Effects Service

class SoundEffectsService {
    static let shared = SoundEffectsService()
    
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    func playButtonTapSound() {
        // Create a soft, pleasant button tap sound
        let soundData = createButtonTapSound()
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer?.volume = 0.3 // Soft volume
            audioPlayer?.play()
        } catch {
            print("Failed to play button tap sound: \(error)")
        }
    }
    
    func playSuccessSound() {
        let soundData = createSuccessSound()
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer?.volume = 0.4
            audioPlayer?.play()
        } catch {
            print("Failed to play success sound: \(error)")
        }
    }
    
    private func createButtonTapSound() -> Data {
        // Create a soft, pleasant tone for button taps
        let sampleRate: Double = 44100
        let duration: Double = 0.1
        let frequency: Double = 800
        
        let samples = Int(sampleRate * duration)
        var audioData = Data()
        
        for i in 0..<samples {
            let time = Double(i) / sampleRate
            let amplitude = sin(2.0 * .pi * frequency * time) * exp(-time * 10) // Exponential decay
            let sample = Int16(amplitude * 8000) // Soft volume
            audioData.append(withUnsafeBytes(of: sample.littleEndian) { Data($0) })
        }
        
        return createWAVData(from: audioData, sampleRate: sampleRate)
    }
    
    private func createSuccessSound() -> Data {
        let sampleRate: Double = 44100
        let duration: Double = 0.3
        let frequency1: Double = 523 // C5
        let frequency2: Double = 659 // E5
        let frequency3: Double = 784 // G5
        
        let samples = Int(sampleRate * duration)
        var audioData = Data()
        
        for i in 0..<samples {
            let time = Double(i) / sampleRate
            let progress = time / duration
            
            var amplitude: Double = 0
            
            // First note (C5)
            if progress < 0.33 {
                let noteTime = time
                amplitude += sin(2.0 * .pi * frequency1 * noteTime) * 0.3 * (1.0 - progress * 3)
            }
            // Second note (E5)
            else if progress < 0.66 {
                let noteTime = time - duration * 0.33
                amplitude += sin(2.0 * .pi * frequency2 * noteTime) * 0.3 * (1.0 - (progress - 0.33) * 3)
            }
            // Third note (G5)
            else {
                let noteTime = time - duration * 0.66
                amplitude += sin(2.0 * .pi * frequency3 * noteTime) * 0.3 * (1.0 - (progress - 0.66) * 3)
            }
            
            let sample = Int16(amplitude * 12000)
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
