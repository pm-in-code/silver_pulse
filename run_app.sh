#!/bin/bash

# Script to run Silver Pulse app on iOS Simulator

echo "🚀 Starting Silver Pulse app..."

# Check if simulator is running
SIMULATOR_STATUS=$(xcrun simctl list devices | grep "iPhone 17 Pro" | grep "Booted")
if [ -z "$SIMULATOR_STATUS" ]; then
    echo "📱 Starting iPhone 17 Pro simulator..."
    xcrun simctl boot "iPhone 17 Pro"
    open -a Simulator
    sleep 5
fi

echo "🔨 Building Silver Pulse app..."

# Try to build and run the app
cd /Users/dmitry/silver_pulse

# First, try to clean and build
echo "🧹 Cleaning project..."
xcodebuild clean -project SilverPulse.xcodeproj -scheme SilverPulse

echo "🔨 Building project..."
xcodebuild -project SilverPulse.xcodeproj -scheme SilverPulse -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "🚀 Installing and running app on simulator..."
    
    # Install the app
    xcrun simctl install "iPhone 17 Pro" "/Users/dmitry/Library/Developer/Xcode/DerivedData/SilverPulse-guaelwdnvfmhizcmcydmgnlvpels/Build/Products/Debug-iphonesimulator/SilverPulse.app"
    
    # Launch the app
    xcrun simctl launch "iPhone 17 Pro" com.silverpulse.app
    
    echo "🎉 Silver Pulse app is now running on iPhone 17 Pro simulator!"
else
    echo "❌ Build failed. Please check the errors above."
    echo "💡 Try opening the project in Xcode and adding missing files to the project."
    echo "📝 Missing files that need to be added to Xcode project:"
    echo "   - SilverPulse/AppState/AppSession.swift"
    echo "   - SilverPulse/Services/PermissionManager.swift (if using enhanced features)"
    echo "   - SilverPulse/Views/Call/WebViewExtensions.swift (if using enhanced features)"
    echo "   - SilverPulse/Views/Call/WebViewUtilities.swift (if using enhanced features)"
fi

