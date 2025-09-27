import Foundation

struct Mood: Identifiable, Codable {
    let id: String
    let title: String
    let imageName: String
    let message: String
    
    static let allMoods: [Mood] = [
        Mood(id: "anxious", title: "Anxious", imageName: "cat_anxious", message: "I'm feeling anxious and need support"),
        Mood(id: "tired", title: "Tired", imageName: "cat_tired", message: "I'm feeling tired and need encouragement"),
        Mood(id: "stressed", title: "Stressed", imageName: "cat_stressed", message: "I'm feeling stressed and need guidance"),
        Mood(id: "overwhelmed", title: "Overwhelmed", imageName: "cat_overwhelmed", message: "I'm feeling overwhelmed and need clarity")
    ]
}
