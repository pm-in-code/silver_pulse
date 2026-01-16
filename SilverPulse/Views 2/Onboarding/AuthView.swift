import SwiftUI

struct AuthView: View {
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.flowPurple, Color.flowPurpleDark],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                ConcentricRings()
                    .frame(height: 220)
                    .padding(.top, 16)
                
                Text("Sign in to begin your conversation")
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                VStack(spacing: 14) {
                    Button(action: onContinue) {
                        HStack(spacing: 12) {
                            Image(systemName: "applelogo")
                                .font(.title2)
                            Text("Continue with Apple")
                                .font(.headline)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(28)
                    }
                    
                    Button(action: onContinue) {
                        HStack(spacing: 12) {
                            Image(systemName: "g.circle.fill")
                                .font(.title2)
                            Text("Continue with Google")
                                .font(.headline)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.flowDark)
                        .cornerRadius(28)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text("By signing in, you agree to our")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    Text("Privacy Policy, Terms of Use, and EULA")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 24)
            }
        }
    }
}

private struct ConcentricRings: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.08))
                .frame(width: 220, height: 220)
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 160, height: 160)
            Circle()
                .fill(Color.white.opacity(0.16))
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    AuthView(onContinue: {})
}
