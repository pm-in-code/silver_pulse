import Foundation

struct Mood: Identifiable, Codable {
    let id: String
    let title: String
    let imageName: String
    let message: String
    
    static let allMoods: [Mood] = [
        Mood(id: "okay", title: "I'm okay", imageName: "mood_okay", message: "I'm feeling okay and ready to chat"),
        Mood(id: "worried", title: "A bit worried", imageName: "mood_worried", message: "I'm feeling a bit worried and need support"),
        Mood(id: "lonely", title: "A little lonely", imageName: "mood_lonely", message: "I'm feeling a little lonely and need connection"),
        Mood(id: "tired", title: "Tired", imageName: "mood_tired", message: "I'm feeling tired and need encouragement")
    ]
}
