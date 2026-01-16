import Foundation

struct Coach: Identifiable, Codable {
    let id: String
    let name: String
    let imageName: String
    let tagline: String
    let webURL: URL
    
    static let allCoaches: [Coach] = [
        Coach(
            id: "lora",
            name: "Lora",
            imageName: "LauraCoach",
            tagline: "Gentle reminders and daily check-ins",
            webURL: URL(string: "https://voxdiscover-videoclient.vercel.app/?video=https://segmentvalue.org/silverpulse/Lora.mp4&id=17b8ec9b-9a82-49a7-1111-111111111111&name=John%20Doe&project=1&assistant_id=c7945cb7-4d0e-45a6-91a2-47eb8b080dc3&img_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/Lora.png&animation_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/orange.json")!
        ),
        Coach(
            id: "matt",
            name: "Matt",
            imageName: "MattCoach",
            tagline: "Calm support, always here day and night",
            webURL: URL(string: "https://voxdiscover-videoclient.vercel.app/?video=https://segmentvalue.org/brayn/blue.mp4&id=12086&name=Evgtitov&project=1&assistant_id=f37c7b64-15b7-44c2-8b6f-083c5c42f3be&img_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/Orra.png&animation_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/lottie_blue.json")!
        ),
        Coach(
            id: "james",
            name: "James",
            imageName: "JamesCoach",
            tagline: "Keeps your mind sharp and your mood lifted",
            webURL: URL(string: "https://voxdiscover-videoclient.vercel.app/?video=https://segmentvalue.org/silverpulse/James.mp4&id=17b8ec9b-9a82-49a7-1111-111111111111&name=John%20Doe&project=1&assistant_id=c7945cb7-4d0e-45a6-91a2-47eb8b080dc3&img_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/James.png&animation_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/green.json")!
        ),
        Coach(
            id: "grace",
            name: "Grace",
            imageName: "EmmaCoach",
            tagline: "Warm listener, real conversations",
            webURL: URL(string: "https://voxdiscover-videoclient.vercel.app/?video=https://segmentvalue.org/silverpulse/Emma.mp4&id=17b8ec9b-9a82-49a7-1111-111111111111&name=John%20Doe&project=1&assistant_id=c7945cb7-4d0e-45a6-91a2-47eb8b080dc3&img_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/Emma.png&animation_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/purple.json")!
        )
    ]
}
