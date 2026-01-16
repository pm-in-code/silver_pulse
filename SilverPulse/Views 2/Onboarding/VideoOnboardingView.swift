import SwiftUI

struct VideoOnboardingView: View {
    let onNext: () -> Void
    
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
                
                Text("VIDEO")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.flowLime)
                
                Spacer()
                
                Button(action: onNext) {
                    Text("NEXT")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 140, height: 44)
                        .background(Color.black)
                        .cornerRadius(22)
                }
                .padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    VideoOnboardingView(onNext: {})
}
