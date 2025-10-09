import Foundation

struct Coach: Identifiable, Codable {
    let id: String
    let name: String
    let imageName: String
    let tagline: String
    let webURL: URL
    
    static let allCoaches: [Coach] = [
        Coach(
            id: "laura",
            name: "Laura",
            imageName: "laura",
            tagline: "Compassionate listener and mindfulness expert",
            webURL: URL(string: "https://voxdiscover-videoclient.vercel.app/?video=https://segmentvalue.org/silverpulse/Lora.mp4&id=17b8ec9b-9a82-49a7-1111-111111111111&name=John%20Doe&project=1&assistant_id=c7945cb7-4d0e-45a6-91a2-47eb8b080dc3&img_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/Lora.png&animation_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/orange.json")!
        ),
        Coach(
            id: "matt",
            name: "Matt",
            imageName: "matt",
            tagline: "Motivational coach and life strategist",
            webURL: URL(string: "https://voxdiscover-videoclient.vercel.app/?video=https://segmentvalue.org/silverpulse/Matt.mp4&id=17b8ec9b-9a82-49a7-1111-111111111111&name=John%20Doe&project=1&assistant_id=c7945cb7-4d0e-45a6-91a2-47eb8b080dc3&img_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/Matt.png&animation_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/blue.json")!
        ),
        Coach(
            id: "james",
            name: "James",
            imageName: "james",
            tagline: "Executive coach and productivity specialist",
            webURL: URL(string: "https://voxdiscover-videoclient.vercel.app/?video=https://segmentvalue.org/silverpulse/James.mp4&id=17b8ec9b-9a82-49a7-1111-111111111111&name=John%20Doe&project=1&assistant_id=c7945cb7-4d0e-45a6-91a2-47eb8b080dc3&img_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/James.png&animation_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/green.json")!
        ),
        Coach(
            id: "emma",
            name: "Emma",
            imageName: "emma",
            tagline: "Wellness coach and stress management expert",
            webURL: URL(string: "https://voxdiscover-videoclient.vercel.app/?video=https://segmentvalue.org/silverpulse/Emma.mp4&id=17b8ec9b-9a82-49a7-1111-111111111111&name=John%20Doe&project=1&assistant_id=c7945cb7-4d0e-45a6-91a2-47eb8b080dc3&img_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/Emma.png&animation_url=https://ufnmrdffbnmwfyisnkfu.supabase.co/storage/v1/object/public/photo/files/Brayn/purple.json")!
        )
    ]
}

