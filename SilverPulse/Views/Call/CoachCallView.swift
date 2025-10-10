import SwiftUI

struct CoachCallView: View {
    let coach: Coach
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // WebView - статичный, без обновлений
            CoachWebViewOnly(coach: coach)
                .ignoresSafeArea()
            
            // UI Overlay - с таймером и кнопками
            VStack {
                CallUIOverlay(coach: coach)
                Spacer()
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .statusBarHidden(false)
    }
}

#Preview {
    CoachCallView(coach: Coach.allCoaches[0])
}
