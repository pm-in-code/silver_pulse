import SwiftUI

struct MoodConfirmationView: View {
    let selectedMood: Mood?
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            if let mood = selectedMood {
                VStack(spacing: 12) {
                    Image(mood.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipped()
                        .cornerRadius(16)
                    
                    Text(mood.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.flowSoftBlue)
                )
            }
            
            if let mood = selectedMood {
                Text(mood.message)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.flowLavender)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                onNext()
            }
        }
        .onTapGesture {
            onNext()
        }
    }
}

#Preview {
    MoodConfirmationView(
        selectedMood: Mood.allMoods.first,
        onNext: {}
    )
}
