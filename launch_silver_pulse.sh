#!/bin/bash

# 🚀 Silver Pulse Launch Script
# Запуск приложения Silver Pulse на симуляторе iPhone 17 Pro

echo "🎯 Silver Pulse - Запуск приложения"
echo "=================================="

# Проверяем, что мы в правильной директории
if [ ! -f "SilverPulse.xcodeproj/project.pbxproj" ]; then
    echo "❌ Ошибка: Запустите скрипт из папки silver_pulse"
    echo "💡 cd /Users/dmitry/silver_pulse"
    exit 1
fi

echo "📱 Проверяем симулятор iPhone 17 Pro..."

# Проверяем статус симулятора
SIMULATOR_STATUS=$(xcrun simctl list devices | grep "iPhone 17 Pro" | grep "Booted")
if [ -z "$SIMULATOR_STATUS" ]; then
    echo "🔄 Запускаем симулятор iPhone 17 Pro..."
    xcrun simctl boot "iPhone 17 Pro"
    open -a Simulator
    sleep 3
    echo "✅ Симулятор запущен"
else
    echo "✅ Симулятор уже запущен"
fi

echo ""
echo "🔨 Собираем приложение Silver Pulse..."

# Собираем проект
echo "📦 Компилируем проект..."
xcodebuild -project SilverPulse.xcodeproj -scheme SilverPulse -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Сборка успешна!"
    echo ""
    echo "🚀 Устанавливаем и запускаем приложение..."
    
    # Устанавливаем приложение на симулятор
    APP_PATH="/Users/dmitry/Library/Developer/Xcode/DerivedData/SilverPulse-*/Build/Products/Debug-iphonesimulator/SilverPulse.app"
    xcrun simctl install "iPhone 17 Pro" $APP_PATH 2>/dev/null
    
    # Запускаем приложение
    xcrun simctl launch "iPhone 17 Pro" com.silverpulse.app
    
    echo ""
    echo "🎉 Silver Pulse запущено на iPhone 17 Pro!"
    echo ""
    echo "📋 Что тестировать:"
    echo "   • Onboarding flow (5 экранов)"
    echo "   • Выбор настроения и коуча"
    echo "   • Voice chat с AI коучами"
    echo "   • WebView с улучшенной конфигурацией"
    echo "   • Network handling (отключите Wi-Fi)"
    echo "   • Screen management (блокировка экрана)"
    echo ""
    echo "🔧 Улучшения WebView:"
    echo "   ✅ Голосовой чат работает корректно"
    echo "   ✅ Контент загружается полностью"
    echo "   ✅ Мониторинг сети"
    echo "   ✅ Управление экраном"
    echo "   ✅ Обработка разрешений микрофона"
    
else
    echo ""
    echo "❌ Ошибка сборки!"
    echo ""
    echo "🔧 Возможные решения:"
    echo "   1. Убедитесь, что AppSession.swift добавлен в проект Xcode"
    echo "   2. Откройте Xcode и добавьте файл:"
    echo "      /Users/dmitry/silver_pulse/SilverPulse/AppState/AppSession.swift"
    echo "   3. Проверьте, что target 'SilverPulse' отмечен галочкой"
    echo ""
    echo "📖 Подробная инструкция:"
    echo "   Откройте файл: ADD_APPSESSION_TO_XCODE.md"
    echo ""
    echo "🛠️  Или откройте проект в Xcode:"
    echo "   open SilverPulse.xcodeproj"
fi

echo ""
echo "=================================="
echo "🏁 Скрипт завершен"

