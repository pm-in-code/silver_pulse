# Инструкции по исправлению изображений

## Проблема
Изображения из Figma не отображаются в приложении.

## Решение
Изображения уже скопированы в проект. Нужно выполнить следующие шаги:

### 1. Откройте проект в Xcode
```bash
open Desktop/SilverPulse1.1/SilverPulse1.1.xcodeproj
```

### 2. Очистите проект
В Xcode:
- Product → Clean Build Folder (Cmd+Shift+K)

### 3. Перезапустите симулятор
- В симуляторе: Device → Restart

### 4. Пересоберите проект
- Product → Build (Cmd+B)
- Product → Run (Cmd+R)

## Проверка
После выполнения этих шагов изображения должны отображаться:
- На экране выбора настроения: котики для каждого настроения
- На экране выбора коуча: фотографии коучей
- В лобби: фотография выбранного коуча

## Структура изображений
```
Assets.xcassets/
├── MoodImages.imageset/
│   ├── mood_okay.png
│   ├── mood_worried.png
│   ├── mood_lonely.png
│   └── mood_tired.png
└── CoachImages.imageset/
    ├── laura.png
    ├── matt.png
    ├── james.png
    └── emma.png
```

## Если изображения все еще не отображаются
1. Убедитесь, что файлы находятся в правильной папке
2. Проверьте, что Contents.json файлы содержат правильные имена файлов
3. Попробуйте удалить DerivedData: Xcode → Preferences → Locations → DerivedData → Delete

