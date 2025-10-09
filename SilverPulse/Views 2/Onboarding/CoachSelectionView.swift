import SwiftUI

struct CoachSelectionView: View {
    @Binding var selectedCoach: Coach?
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
                // Header
                VStack(spacing: 6) {
                    Text("Choose Your Companion")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text("You can change anytime")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
            
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
                        .padding(.vertical, 16)
                        .background(selectedCoach != nil ? Color.accentColor : Color(.systemGray4))
                        .cornerRadius(12)
                }
                .disabled(selectedCoach == nil)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
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
                    .aspectRatio(contentMode: .fit) // Используем .fit чтобы не обрезать изображение
                    .frame(width: 100, height: 100) // Увеличиваем размер изображения
                    .clipShape(Circle())
                
                // Coach Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(coach.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(coach.tagline)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                
                Spacer()
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}

#Preview {
    CoachSelectionView(
        selectedCoach: .constant(nil),
        onNext: {}
    )
}
