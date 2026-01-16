import SwiftUI

struct CoachSelectionView: View {
    @Binding var selectedCoach: Coach?
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            VStack(alignment: .leading, spacing: 6) {
                Text("Choose Your\nCompanion")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text("You can change anytime")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            // Coach List
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(Coach.allCoaches) { coach in
                        OnboardingCoachCard(
                            coach: coach,
                            isSelected: selectedCoach?.id == coach.id
                        ) {
                            selectedCoach = coach
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            
            // Continue Button
            Button(action: onNext) {
                Text("LET'S TALK")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(selectedCoach != nil ? Color.flowSoftBlue : Color(.systemGray4))
                    .cornerRadius(24)
            }
            .buttonStyle(FeedbackButtonStyle(feedbackType: .success))
            .disabled(selectedCoach == nil)
            .padding(.horizontal, 40)
            
            Text("Pick who feels right. We'll take it slow")
                .font(.footnote)
                .foregroundColor(Color.flowSoftBlue)
                .padding(.bottom, 20)
        }
        .background(Color.flowLavender)
    }
    
}

struct OnboardingCoachCard: View {
    let coach: Coach
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Coach Photo
                Image(coach.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipped()
                    .cornerRadius(12)
                
                // Coach Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(coach.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(coach.tagline)
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.flowSoftBlue : Color.clear, lineWidth: 2)
            )
            }
            .buttonStyle(FeedbackButtonStyle(feedbackType: .selection))
        }
    
}

#Preview {
    CoachSelectionView(
        selectedCoach: .constant(nil),
        onNext: {}
    )
}
