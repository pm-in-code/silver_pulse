# Silver Pulse iOS App

A SwiftUI iOS app for coach calls with server-enforced time limits.

## Features

- **Onboarding Flow**: 5-screen onboarding with mood selection and coach choice
- **Coach Calls**: WebView-based coach calls with time tracking
- **Server-Enforced Limits**: 4-hour total time limit enforced by backend
- **Real-time Sync**: Server time synchronization and heartbeat mechanism
- **Background Handling**: Auto-stop calls when app goes to background > 30s

## Architecture

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Navigation**: NavigationStack
- **Architecture**: Lightweight MVVM
- **Services**: APIClient, QuotaService, TimeSync, Analytics

## Project Structure

```
SilverPulse/
├── Models/           # Data models (Mood, Coach, UserQuota, CallSession)
├── Views/
│   ├── Onboarding/   # 5 onboarding screens
│   ├── Lobby/        # Main lobby with coach card and timer
│   └── Call/         # WebView-based coach call interface
├── Services/         # API client, quota service, time sync, analytics
├── AppState/         # App session management
├── ViewModels/       # View models for data binding
└── Assets.xcassets/  # App assets and colors
```

## Key Components

### Models
- `Mood`: User mood selection with title, image, and message
- `Coach`: Coach information with web URL for calls
- `UserQuota`: Server quota information with remaining time
- `CallSession`: Active call session tracking

### Services
- `APIClient`: REST API client with mock mode for development
- `QuotaService`: Manages user quota and call sessions
- `TimeSync`: Handles server time synchronization
- `Analytics`: Event tracking and analytics

### Views
- `OnboardingFlowView`: Complete onboarding experience
- `LobbyView`: Main interface with coach card and call button
- `CoachWebView`: WebView container for coach calls

## API Endpoints

The app integrates with these backend endpoints:

- `GET /v1/me/quota` - Get user quota information
- `POST /v1/calls/start` - Start a new call session
- `POST /v1/calls/heartbeat` - Send heartbeat during active call
- `POST /v1/calls/stop` - Stop active call session

## Mock API

For development, the app includes a mock API mode (`USE_MOCK_API = true`) that:
- Returns a 4-hour total quota
- Decrements time by 15 seconds per heartbeat
- Simulates server responses with realistic data

## Colors

- **Lime**: #E6FF00 (primary accent)
- **Accent**: #6D6DFF (secondary accent)
- **Background**: #F7F7FC (light background)

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Setup

1. Open `SilverPulse.xcodeproj` in Xcode
2. Build and run on simulator or device
3. The app will use mock API by default

## Features Implemented

✅ Complete onboarding flow (5 screens)
✅ Mood selection with daily reminder toggle
✅ Coach selection with visual cards
✅ Lobby interface with timer and call button
✅ WebView-based coach calls
✅ Server-enforced time limits
✅ Real-time quota tracking
✅ Background handling and auto-stop
✅ Microphone permission handling
✅ Analytics event tracking
✅ Mock API for development
✅ Time synchronization
✅ Heartbeat mechanism
✅ Error handling and alerts

## Next Steps

1. Replace placeholder images with actual coach photos
2. Implement real backend API integration
3. Add push notifications for daily reminders
4. Implement user authentication
5. Add accessibility features
6. Add unit and UI tests

