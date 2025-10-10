import SwiftUI

struct MoodConfirmationView: View {
    let selectedMood: Mood?
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Mood Icon
            if let mood = selectedMood {
                Image(mood.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 4)
                    )
            }
            
            // Confirmation Message
            VStack(spacing: 16) {
                Text("I understand you're feeling")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                if let mood = selectedMood {
                    Text(mood.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                }
                
                Text("That's completely okay. We're here to help you feel better.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            
            Spacer()
            
                // Continue Button
                Button(action: onNext) {
                    HStack {
                        Text("Let's find your coach")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.accentColor)
                    .cornerRadius(12)
                }
                .buttonStyle(FeedbackButtonStyle(feedbackType: .success))
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    MoodConfirmationView(
        selectedMood: Mood.allMoods.first,
        onNext: {}
    )
}
