# Добавление файлов запуска и музыки в Xcode

## Необходимо добавить следующие файлы в проект Xcode:

### 1. LoadingScreenView.swift
- **Путь**: `SilverPulse/Views/Launch/LoadingScreenView.swift`
- **Тип**: SwiftUI View для стартового экрана с анимацией

### 2. BackgroundMusicService.swift
- **Путь**: `SilverPulse/Services/BackgroundMusicService.swift`
- **Тип**: Service class для управления фоновой музыкой

## Инструкции по добавлению:

### Добавление LoadingScreenView.swift:
1. Откройте Xcode проект `SilverPulse.xcodeproj`
2. В Project Navigator найдите папку `Views`
3. Создайте папку `Launch` если её нет:
   - Правый клик на папке `Views` → "New Group" → назовите "Launch"
4. Правый клик на папке `Launch` → "Add Files to SilverPulse"
5. Выберите файл `LoadingScreenView.swift`
6. Убедитесь что "Add to target: SilverPulse" отмечен
7. Нажмите "Add"

### Добавление BackgroundMusicService.swift:
1. В Project Navigator найдите папку `Services`
2. Правый клик на папке `Services` → "Add Files to SilverPulse"
3. Выберите файл `BackgroundMusicService.swift`
4. Убедитесь что "Add to target: SilverPulse" отмечен
5. Нажмите "Add"

## Проверка:
После добавления всех файлов проект должен собираться без ошибок и показывать:
1. Красивый стартовый экран с анимацией при запуске
2. Фоновую музыку во время использования приложения
3. Автоматическую остановку музыки во время звонков с коучем
4. Вибро-отклик и звуки при нажатии на кнопки

## Функции:
- ✅ **Стартовый экран**: Анимированный логотип с пульсацией
- ✅ **Фоновая музыка**: Спокойная, расслабляющая музыка
- ✅ **Умное управление**: Музыка останавливается во время звонков
- ✅ **Вибро-отклик**: Легкие вибрации при нажатии кнопок
- ✅ **Звуки кнопок**: Мягкие звуки при взаимодействии

