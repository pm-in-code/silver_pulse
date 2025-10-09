# Инструкция по созданию проекта в Xcode

## Создание нового проекта:

1. **Откройте Xcode**
2. **File → New → Project**
3. **Выберите iOS → App**
4. **Настройки проекта:**
   - Product Name: `SilverPulse`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Bundle Identifier: `com.silverpulse.app`
   - Use Core Data: `NO`
   - Include Tests: `NO`
5. **Сохраните в папку:** `/Users/dmitry/silver_pulse/`
6. **Замените содержимое созданных файлов**

## Замена файлов:

### 1. SilverPulseApp.swift
Замените содержимое на:
```swift
import SwiftUI

@main
struct SilverPulseApp: App {
    @StateObject private var appSession = AppSession()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appSession)
                .onAppear {
                    setupAudioSession()
                }
        }
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
}

import AVFoundation
```

### 2. ContentView.swift
Замените содержимое на:
```swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSession: AppSession
    @State private var isOnboardingComplete = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isOnboardingComplete {
                    LobbyView()
                } else {
                    OnboardingFlowView(isComplete: $isOnboardingComplete)
                }
            }
            .onAppear {
                checkOnboardingStatus()
            }
        }
    }
    
    private func checkOnboardingStatus() {
        isOnboardingComplete = appSession.selectedMood != nil && appSession.selectedCoach != nil
    }
}

#Preview {
    ContentView()
        .environmentObject(AppSession())
}
```

## Добавление файлов в проект:

1. **Правый клик на группе "SilverPulse" в навигаторе**
2. **Add Files to "SilverPulse"**
3. **Выберите папку `SilverPulse/`**
4. **Отметьте:**
   - ✅ Create groups
   - ✅ Add to target: SilverPulse
5. **Нажмите Add**

## Настройка проекта:

1. **Выберите проект "SilverPulse" в навигаторе**
2. **Target → SilverPulse → Info**
3. **Добавьте в Info.plist:**
   - `NSMicrophoneUsageDescription`: "This app needs microphone access for coach calls."

## Готово!

Теперь проект должен компилироваться без ошибок.

