# Инструкции по сборке Silver Pulse с улучшениями WebView

## Предварительные требования

- macOS с Xcode 15.0+
- iOS 17.0+ SDK
- Swift 5.9+

## Шаги сборки

### 1. Откройте проект в Xcode

```bash
cd /Users/dmitry/silver_pulse
open SilverPulse.xcodeproj
```

### 2. Проверьте настройки проекта

В Xcode убедитесь, что:
- Deployment Target установлен на iOS 17.0+
- Swift Language Version: Swift 5
- Build Configuration: Debug (для тестирования)

### 3. Добавьте новые файлы в проект

Убедитесь, что следующие файлы добавлены в Xcode проект:

**Новые файлы:**
- `SilverPulse/Views/Call/WebViewExtensions.swift`
- `SilverPulse/Views/Call/WebViewUtilities.swift`
- `SilverPulse/Services/PermissionManager.swift`

**Измененные файлы:**
- `SilverPulse/Views/Call/CoachWebView.swift`
- `SilverPulse/SilverPulseApp.swift`

### 4. Проверьте импорты

Убедитесь, что все необходимые фреймворки подключены:
- WebKit
- Network
- AVFoundation
- UIKit
- SwiftUI
- Combine

### 5. Настройте разрешения

В `Info.plist` добавьте следующие разрешения:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Silver Pulse needs microphone access to enable voice chat with your coach.</string>
<key>NSCameraUsageDescription</key>
<string>Silver Pulse may need camera access for video calls.</string>
```

### 6. Соберите проект

```bash
# В Xcode: Product → Build (⌘+B)
# Или через командную строку:
xcodebuild -project SilverPulse.xcodeproj -scheme SilverPulse -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build
```

### 7. Запустите на симуляторе

```bash
# В Xcode: Product → Run (⌘+R)
# Или через командную строку:
xcodebuild -project SilverPulse.xcodeproj -scheme SilverPulse -destination 'platform=iOS Simulator,name=iPhone 15 Pro' test
```

## Тестирование улучшений

### 1. Тест голосового чата

1. Запустите приложение
2. Пройдите onboarding
3. Выберите коуча
4. Нажмите "CALL"
5. Проверьте, что микрофон работает
6. Убедитесь, что контент загружается полностью

### 2. Тест мониторинга сети

1. Начните звонок
2. Отключите Wi-Fi/мобильные данные
3. Убедитесь, что звонок автоматически завершается
4. Включите сеть обратно
5. Проверьте восстановление соединения

### 3. Тест управления экраном

1. Начните звонок
2. Убедитесь, что экран не блокируется
3. Переведите приложение в фон на 30+ секунд
4. Проверьте автоматическое завершение звонка

### 4. Тест разрешений

1. При первом запуске отклоните разрешение микрофона
2. Убедитесь, что показывается алерт с предложением настроить разрешения
3. Перейдите в настройки и включите микрофон
4. Вернитесь в приложение и проверьте работу

## Возможные проблемы и решения

### Проблема: WebView не загружается

**Решение:**
- Проверьте интернет-соединение
- Убедитесь, что URL коуча корректный
- Проверьте логи в консоли Xcode

### Проблема: Микрофон не работает

**Решение:**
- Проверьте разрешения в настройках iOS
- Убедитесь, что аудиосессия настроена корректно
- Проверьте, что устройство поддерживает запись

### Проблема: Ошибки компиляции

**Решение:**
- Убедитесь, что все новые файлы добавлены в проект
- Проверьте импорты фреймворков
- Очистите проект: Product → Clean Build Folder

### Проблема: Контент отображается некорректно

**Решение:**
- Проверьте JavaScript инъекции в WebViewUtilities.swift
- Убедитесь, что центрирование контента работает
- Проверьте настройки WebView

## Отладка

### Включение детального логирования

В `CoachWebView.swift` добавьте:

```swift
#if DEBUG
print("WebView Debug: \(debugDescription)")
#endif
```

### Мониторинг производительности

Используйте Instruments в Xcode для отслеживания:
- Использования памяти
- Производительности WebView
- Сетевых запросов

## Производственная сборка

Для сборки production версии:

```bash
xcodebuild -project SilverPulse.xcodeproj -scheme SilverPulse -configuration Release -destination 'generic/platform=iOS' build
```

## Дополнительные настройки

### Оптимизация для App Store

1. Включите оптимизации компилятора
2. Удалите отладочные символы
3. Настройте code signing
4. Проверьте требования App Store

### Настройка CI/CD

Создайте скрипт сборки для автоматизации:

```bash
#!/bin/bash
# build.sh
set -e

echo "Building Silver Pulse..."
xcodebuild -project SilverPulse.xcodeproj -scheme SilverPulse -configuration Release build

echo "Build completed successfully!"
```

## Поддержка

При возникновении проблем:

1. Проверьте логи в Xcode Console
2. Убедитесь, что все зависимости установлены
3. Проверьте версии iOS и Xcode
4. Обратитесь к документации Apple Developer

## Заключение

После выполнения всех шагов приложение Silver Pulse будет содержать все улучшения WebView для корректной работы голосового чата с AI Voice coach.

