import SwiftUI

struct MoodSelectionView: View {
    @Binding var selectedMood: Mood?
    @Binding var dailyReminder: Bool
    let onNext: () -> Void
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 32) {
            // Header
            VStack(spacing: 16) {
                Text("How are you feeling?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Select the mood that best describes you right now")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)
            
            // Mood Grid
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Mood.allMoods) { mood in
                    MoodCard(
                        mood: mood,
                        isSelected: selectedMood?.id == mood.id
                    ) {
                        selectedMood = mood
                    }
                }
            }
            .padding(.horizontal, 24)
            
            // Daily Reminder Toggle
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.accentColor)
                    Text("Remind me daily to stay active")
                        .font(.body)
                        .fontWeight(.medium)
                    Spacer()
                }
                
                Toggle("", isOn: $dailyReminder)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal, 24)
            
            Spacer()
            
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
                .background(selectedMood != nil ? Color.accentColor : Color.gray)
                .cornerRadius(12)
            }
            .disabled(selectedMood == nil)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
    }
}

struct MoodCard: View {
    let mood: Mood
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                Image(mood.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text(mood.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.accentColor : Color(.systemGray6))
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
    MoodSelectionView(
        selectedMood: .constant(nil),
        dailyReminder: .constant(false),
        onNext: {}
    )
}
