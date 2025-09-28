import SwiftUI

struct FinalConfirmationView: View {
    let selectedMood: Mood?
    let selectedCoach: Coach?
    @Binding var userName: String
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Coach Photo
            if let coach = selectedCoach {
                Image(coach.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 4)
                    )
            }
            
            // Confirmation Message
            VStack(spacing: 16) {
                Text("Great—let's start talking,")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                TextField("Your name", text: $userName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.accentColor)
                            .offset(y: 20)
                    )
                
                if let coach = selectedCoach {
                    Text("with \(coach.name)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 24)
            
            // Summary
            VStack(spacing: 12) {
                if let mood = selectedMood {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.accentColor)
                        Text("Feeling: \(mood.title)")
                            .font(.body)
                        Spacer()
                    }
                }
                
                if let coach = selectedCoach {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.accentColor)
                        Text("Coach: \(coach.name)")
                            .font(.body)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal, 24)
            
            Spacer()
            
            // Start Button
            Button(action: onComplete) {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Start Your Journey")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(userName.isEmpty ? Color.gray : Color.accentColor)
                .cornerRadius(12)
            }
            .disabled(userName.isEmpty)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    FinalConfirmationView(
        selectedMood: Mood.allMoods.first,
        selectedCoach: Coach.allCoaches.first,
        userName: .constant("John"),
        onComplete: {}
    )
}
