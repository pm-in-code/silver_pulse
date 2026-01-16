import SwiftUI

struct LoadingScreenView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.flowPurple, Color.flowPurpleDark],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 240, height: 240)
                    Circle()
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 170, height: 170)
                    Circle()
                        .fill(Color.white.opacity(0.18))
                        .frame(width: 110, height: 110)
                }
                
                Spacer()
                
                VStack(spacing: 6) {
                    Text("SILVER\nPULSE")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text("Never alone")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 40)
            }
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

