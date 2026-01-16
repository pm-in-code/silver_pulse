import SwiftUI

struct MoodSelectionView: View {
    @Binding var selectedMood: Mood?
    @Binding var dailyReminder: Bool
    let onNext: () -> Void
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("How are you feeling\ntoday?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Text("This will make our chat more helpful\nfor you")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 24)
            
            // Mood Grid
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Mood.allMoods) { mood in
                    MoodCard(
                        mood: mood,
                        isSelected: selectedMood?.id == mood.id,
                        onTap: {
                            selectedMood = mood
                            onNext()
                        },
                        selectionColor: Color.flowSoftBlue
                    )
                }
            }
            .padding(.horizontal, 24)
            
            // Daily Reminder Toggle - checkbox style
            Button(action: { dailyReminder.toggle() }) {
                HStack(spacing: 10) {
                    Image(systemName: dailyReminder ? "checkmark.square.fill" : "square")
                        .foregroundColor(Color.flowSoftBlue)
                    Text("Remind me daily to stay active")
                        .font(.body)
                        .foregroundColor(Color.flowSoftBlue)
                    Spacer()
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 24)
            
            Spacer()
        }
        // Внешние отступы относительно краёв экрана
        .padding(.top, 24)
        .padding(.bottom, 24)
        .background(Color.flowLavender)
    }
}

struct MoodCard: View {
    let mood: Mood
    let isSelected: Bool
    let onTap: () -> Void
    let selectionColor: Color
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 10) {
                Image(mood.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(12)
                
                Text(mood.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? selectionColor : Color.white)
            )
        }
        .buttonStyle(FeedbackButtonStyle(feedbackType: .selection))
    }
    
}

#Preview {
    MoodSelectionView(
        selectedMood: .constant(nil),
        dailyReminder: .constant(false),
        onNext: {}
    )
}
