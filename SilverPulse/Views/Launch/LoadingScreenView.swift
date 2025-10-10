import SwiftUI

struct LoadingScreenView: View {
    @State private var isAnimating = false
    @State private var pulseScale: CGFloat = 1.0
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var dotsOpacity: Double = 0.0
    @State private var dotOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemGray6),
                    Color(.systemGray5),
                    Color(.systemGray6)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Logo with animation
                VStack(spacing: 20) {
                    // Main logo circle with pulse animation
                    ZStack {
                        // Outer pulse ring
                        Circle()
                            .stroke(Color.accentColor.opacity(0.3), lineWidth: 2)
                            .frame(width: 120, height: 120)
                            .scaleEffect(pulseScale)
                            .animation(
                                .easeInOut(duration: 2.0)
                                .repeatForever(autoreverses: true),
                                value: pulseScale
                            )
                        
                        // Inner pulse ring
                        Circle()
                            .stroke(Color.accentColor.opacity(0.5), lineWidth: 1)
                            .frame(width: 80, height: 80)
                            .scaleEffect(pulseScale * 0.8)
                            .animation(
                                .easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: true)
                                .delay(0.5),
                                value: pulseScale
                            )
                        
                        // Main logo
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.accentColor,
                                        Color.accentColor.opacity(0.8)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "heart.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            )
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .animation(
                                .easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true),
                                value: isAnimating
                            )
                    }
                    
                    // App name
                    Text("Silver Pulse")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .opacity(logoOpacity)
                    
                    // Tagline
                    Text("Your AI Companion for Wellness")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .opacity(textOpacity)
                }
                
                Spacer()
                
                // Loading indicator
                VStack(spacing: 16) {
                    // Animated dots
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 8, height: 8)
                                .offset(y: dotOffset)
                                .animation(
                                    .easeInOut(duration: 0.6)
                                    .repeatForever(autoreverses: true)
                                    .delay(Double(index) * 0.2),
                                    value: dotOffset
                                )
                        }
                    }
                    .opacity(dotsOpacity)
                    
                    // Loading text
                    Text("Preparing your experience...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .opacity(textOpacity)
                }
                
                Spacer()
            }
            .padding(.horizontal, 40)
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Start pulse animation
        pulseScale = 1.3
        
        // Fade in logo
        withAnimation(.easeInOut(duration: 1.0).delay(0.5)) {
            logoOpacity = 1.0
        }
        
        // Fade in text
        withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
            textOpacity = 1.0
        }
        
        // Start dots animation
        withAnimation(.easeInOut(duration: 1.0).delay(1.5)) {
            dotsOpacity = 1.0
        }
        
        // Start dots bouncing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            dotOffset = -10
        }
        
        // Start main logo animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isAnimating = true
        }
    }
}

// MARK: - Loading Screen Manager

class LoadingScreenManager: ObservableObject {
    @Published var isLoading = true
    
    func finishLoading() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isLoading = false
        }
    }
}

#Preview {
    LoadingScreenView()
}
