import SwiftUI

struct ImageOnboardingIntroView: View {
    let onNext: () -> Void
    
    var body: some View {
        ZStack {
            Color.flowLavender.ignoresSafeArea()
            
            VStack(spacing: 16) {
                Spacer()
                
                VStack(spacing: 8) {
                    Text("START")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("A CONVERSATION")
                        .font(.title2)
                        .fontWeight(.bold)
                    HStack(spacing: 6) {
                        Text("IN")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("10 SECONDS")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.flowSoftBlue)
                            .cornerRadius(6)
                    }
                }
                .foregroundColor(.black)
                
                Spacer()
                
                VStack(spacing: 12) {
                    Text("SILVER PULSE")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .opacity(0.6)
                    
                    Text("Tap the button. Say anything\non your mind. Silver Pulse\nresponds instantly")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .background(Color.flowSoftBlue)
                        .cornerRadius(16)
                }
                
                Button(action: onNext) {
                    Text("NEXT")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 120, height: 44)
                        .background(Color.black)
                        .cornerRadius(22)
                }
                .padding(.top, 8)
                
                OnboardingDots(currentIndex: 0)
                    .padding(.bottom, 24)
            }
        }
    }
}

struct ImageOnboardingCoachListView: View {
    @Binding var selectedCoach: Coach?
    let onNext: () -> Void
    
    var body: some View {
        ZStack {
            Color.flowSoftBlue.ignoresSafeArea()
            
            VStack(spacing: 16) {
                VStack(spacing: 4) {
                    HStack(spacing: 6) {
                        Text("CHOOSE")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.flowLime)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.black)
                            .cornerRadius(4)
                        Text("WHO YOU")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Text("WANT TO TALK TO")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.top, 16)
                
                VStack(spacing: 10) {
                    ForEach(Coach.allCoaches) { coach in
                        Button(action: { selectedCoach = coach }) {
                            HStack(spacing: 12) {
                                Image(coach.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 44, height: 44)
                                    .clipped()
                                    .cornerRadius(10)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(coach.name)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Text(coach.tagline)
                                        .font(.caption)
                                        .foregroundColor(.black.opacity(0.7))
                                }
                                Spacer()
                            }
                            .padding(10)
                            .background(selectedCoach?.id == coach.id ? Color.flowLime : Color.white.opacity(0.9))
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                VStack(spacing: 12) {
                    Text("Each companion has\na different tone and personality.\nYou can always switch later")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    
                    Button(action: onNext) {
                        Text("NEXT")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 44)
                            .background(Color.black)
                            .cornerRadius(22)
                    }
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.flowDark)
                .cornerRadius(24)
                
                OnboardingDots(currentIndex: 1)
                    .padding(.bottom, 16)
            }
        }
    }
}

struct ImageOnboardingReadyView: View {
    let onNext: () -> Void
    
    var body: some View {
        ZStack {
            Color.flowDark.ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("YOU'RE READY")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.flowLime)
                Text("TO START")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 220, height: 220)
                    .overlay(
                        Image("MattCoach")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    )
                
                Spacer()
                
                VStack(spacing: 12) {
                    Text("Your companion will listen\nand respond in real time. Just\nchoose what feels right for you")
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    
                    Button(action: onNext) {
                        Text("NEXT")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 44)
                            .background(Color.black)
                            .cornerRadius(22)
                    }
                }
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity)
                .background(Color.flowLime)
                .cornerRadius(28)
                
                OnboardingDots(currentIndex: 2)
                    .padding(.bottom, 16)
            }
            .padding(.top, 16)
        }
    }
}

struct OnboardingDots: View {
    let currentIndex: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(index == currentIndex ? Color.black : Color.black.opacity(0.3))
                    .frame(width: 6, height: 6)
            }
        }
    }
}

#Preview {
    ImageOnboardingIntroView(onNext: {})
}
