import Foundation

struct Mood: Identifiable, Codable {
    let id: String
    let title: String
    let imageName: String
    let message: String
    
    static let allMoods: [Mood] = [
        Mood(id: "lonely", title: "Lonely", imageName: "LonelyMood", message: "I'm feeling lonely and need connection"),
        Mood(id: "worried", title: "Worried", imageName: "WorriedMood", message: "I'm feeling worried and need reassurance"),
        Mood(id: "tired", title: "Tired", imageName: "TiredMood", message: "I'm feeling tired and need encouragement"),
        Mood(id: "okay", title: "Okay", imageName: "OkayMood", message: "I'm feeling okay and ready to connect")
    ]
}
