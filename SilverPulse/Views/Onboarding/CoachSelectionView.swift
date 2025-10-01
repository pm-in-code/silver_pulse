import SwiftUI

struct CoachSelectionView: View {
    @Binding var selectedCoach: Coach?
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            // Header
            VStack(spacing: 16) {
                Text("Choose your coach")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Select the coach who resonates with you most")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)
            
            // Coach List
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Coach.allCoaches) { coach in
                        CoachCard(
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
                HStack {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(selectedCoach != nil ? Color.accentColor : Color.gray)
                .cornerRadius(12)
            }
            .disabled(selectedCoach == nil)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
    }
}

struct CoachCard: View {
    let coach: Coach
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Coach Photo
                Image(coach.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 3)
                    )
                
                // Coach Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(coach.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(isSelected ? .accentColor : .primary)
                    
                    Text(coach.tagline)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                // Selection Indicator
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.accentColor.opacity(0.1) : Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
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
