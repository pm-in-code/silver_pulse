import SwiftUI

struct PurchaseSuccessView: View {
    let onStart: () -> Void
    
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
                
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 180, height: 180)
                    Circle()
                        .fill(Color.white.opacity(0.22))
                        .frame(width: 120, height: 120)
                    Image(systemName: "checkmark")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("Your minutes\nare active")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("Start a voice session anytime")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                
                Button(action: onStart) {
                    Text("START")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 140, height: 44)
                        .background(Color.black)
                        .cornerRadius(22)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    PurchaseSuccessView(onStart: {})
}
