import Foundation

struct Mood: Identifiable, Codable {
    let id: String
    let title: String
    let imageName: String
    let message: String
    
    static let allMoods: [Mood] = [
        Mood(id: "okay", title: "I'm okay", imageName: "OkayMood", message: "Got it. We'll keep things light and easy."),
        Mood(id: "lonely", title: "A little lonely", imageName: "LonelyMood", message: "Got it. We'll keep things gentle and supportive."),
        Mood(id: "worried", title: "A bit worried", imageName: "WorriedMood", message: "Got it. We'll keep things calm and reassuring."),
        Mood(id: "tired", title: "Tired", imageName: "TiredMood", message: "Got it. We'll keep things short and easy.")
    ]
}
