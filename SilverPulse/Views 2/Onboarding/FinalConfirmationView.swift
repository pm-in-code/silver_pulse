import SwiftUI

struct FinalConfirmationView: View {
    let selectedCoach: Coach?
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("You're all set")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Your companion is here and ready\nfor a real conversation")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            Spacer()
            
            if let coach = selectedCoach {
                VStack(spacing: 12) {
                    Image(coach.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipped()
                        .cornerRadius(16)
                    
                    Text(coach.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.flowSoftBlue)
                )
                
                Text(coach.tagline)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
            
            Text("Private & secure.\nConversations only happen\nwhen you press \"Talk\"")
                .font(.caption)
                .foregroundColor(Color.flowSoftBlue)
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.flowLavender)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                onComplete()
            }
        }
        .onTapGesture {
            onComplete()
        }
    }
}

#Preview {
    FinalConfirmationView(
        selectedCoach: Coach.allCoaches.first,
        onComplete: {}
    )
}
