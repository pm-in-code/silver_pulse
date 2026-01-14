import SwiftUI

struct MoodSelectionView: View {
    @Binding var selectedMood: Mood?
    @Binding var dailyReminder: Bool
    let onNext: () -> Void
    
    // Custom selection color (green #D5F20E)
    private let selectionColor = Color(red: 0xD5 / 255.0, green: 0xF2 / 255.0, blue: 0x0E / 255.0)
    
    private let columns = [
        GridItem(.flexible(), spacing: 32),
        GridItem(.flexible(), spacing: 32)
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            VStack(spacing: 12) {
                Text("How are you feeling?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                Text("Select the mood that best describes you right now")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 24)
            
            // Mood Grid
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Mood.allMoods) { mood in
                    MoodCard(
                        mood: mood,
                        isSelected: selectedMood?.id == mood.id,
                        onTap: {
                            selectedMood = mood
                        },
                        selectionColor: selectionColor
                    )
                }
            }
            .padding(.horizontal, 24)
            
            // Daily Reminder Toggle - compact one-line layout
            HStack(spacing: 12) {
                Image(systemName: "bell.fill")
                    .foregroundColor(.accentColor)
                Text("Remind me daily to stay active")
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
                Toggle("", isOn: $dailyReminder)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
                // Continue Button
                Button(action: onNext) {
                    HStack {
                        Text("Continue")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(selectedMood != nil ? selectionColor : Color.gray)
                    .cornerRadius(12)
                }
                .buttonStyle(FeedbackButtonStyle(feedbackType: .success))
                .disabled(selectedMood == nil)
                .padding(.horizontal, 24)
        }
        // Внешние отступы относительно краёв экрана
        .padding(.top, 72)
        .padding(.bottom, 72)
        // Swap background colors: screen gets light gray, tiles get white
        .background(Color(.systemGray6))
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
                        // Make image vertical 3:4
                        .scaledToFill()
                        .aspectRatio(3.0 / 4.0, contentMode: .fill)
                        .clipped()
                    
                    Text(mood.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(isSelected ? .black : .primary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        // Swap colors: unselected tiles are white, selected use custom green
                        .fill(isSelected ? selectionColor : Color(.systemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? selectionColor : Color.clear, lineWidth: 2)
                )
                // Clip entire tile to rounded rectangle so image corners are masked
                .clipShape(RoundedRectangle(cornerRadius: 16))
                // Make the whole tile vertical rectangle with slightly reduced height
                .aspectRatio(3.0 / 3.8, contentMode: .fit)
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
