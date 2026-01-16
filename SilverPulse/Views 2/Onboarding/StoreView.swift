import SwiftUI

struct StoreView: View {
    let onPurchase: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.flowPurple, Color.flowPurpleDark],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("CHOOSE THE TIME")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("STAY CONNECTED, SUPPORTED\n& INDEPENDENT")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                
                StorePlanCard(
                    title: "Instant",
                    minutes: "10 min",
                    price: "$7.99",
                    badge: "LIMITED OFFER",
                    highlight: true,
                    subtitle: "Perfect for short chats ✓",
                    onPurchase: onPurchase
                )
                
                StorePlanCard(
                    title: "Comfort",
                    minutes: "60 min",
                    price: "$36.99",
                    badge: "MOST POPULAR",
                    highlight: false,
                    subtitle: nil,
                    onPurchase: onPurchase
                )
                
                StorePlanCard(
                    title: "Premium",
                    minutes: "300 min",
                    price: "$159.99",
                    badge: "BEST VALUE",
                    highlight: false,
                    subtitle: nil,
                    onPurchase: onPurchase
                )
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
        }
        .onTapGesture {
            // quick demo flow: tap anywhere to proceed if needed
        }
    }
}

private struct StorePlanCard: View {
    let title: String
    let minutes: String
    let price: String
    let badge: String?
    let highlight: Bool
    let subtitle: String?
    let onPurchase: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(minutes)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                Spacer()
                if let badge {
                    Text(badge)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(badge == "LIMITED OFFER" ? Color.red : Color.flowDark)
                        .cornerRadius(8)
                }
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(price)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Button(action: onPurchase) {
                    Text("GET")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: 70, height: 34)
                        .background(Color.flowLime)
                        .cornerRadius(17)
                }
            }
            
            if let subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(16)
        .background(highlight ? Color.black.opacity(0.9) : Color.flowSoftBlue.opacity(0.9))
        .cornerRadius(20)
        .onTapGesture {
            // placeholder tap
        }
    }
}

#Preview {
    StoreView(onPurchase: {})
}
