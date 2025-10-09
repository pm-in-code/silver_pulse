#!/bin/bash

# 🔧 Скрипт для исправления проекта Xcode Silver Pulse
# Добавляет все недостающие файлы в проект

echo "🔧 Silver Pulse - Исправление проекта Xcode"
echo "=========================================="

# Проверяем, что мы в правильной директории
if [ ! -f "SilverPulse.xcodeproj/project.pbxproj" ]; then
    echo "❌ Ошибка: Запустите скрипт из папки silver_pulse"
    echo "💡 cd /Users/dmitry/silver_pulse"
    exit 1
fi

echo "📋 Проблема: Не все Swift файлы добавлены в проект Xcode"
echo ""
echo "🔍 Найдены следующие файлы, которые нужно добавить:"
echo ""

# Показываем файлы, которые нужно добавить
echo "📁 Models:"
find SilverPulse/Models -name "*.swift" 2>/dev/null | while read file; do
    echo "   • $file"
done

echo ""
echo "📁 Services:"
find SilverPulse/Services -name "*.swift" 2>/dev/null | while read file; do
    echo "   • $file"
done

echo ""
echo "📁 ViewModels:"
find SilverPulse/ViewModels -name "*.swift" 2>/dev/null | while read file; do
    echo "   • $file"
done

echo ""
echo "📁 Views:"
find SilverPulse/Views -name "*.swift" 2>/dev/null | while read file; do
    echo "   • $file"
done

echo ""
echo "📁 Основные файлы:"
find SilverPulse -maxdepth 1 -name "*.swift" 2>/dev/null | while read file; do
    echo "   • $file"
done

echo ""
echo "🔧 РЕШЕНИЕ:"
echo "==========="
echo ""
echo "1. Откройте проект в Xcode:"
echo "   open SilverPulse.xcodeproj"
echo ""
echo "2. Добавьте все папки в проект:"
echo "   • Правый клик на папке 'SilverPulse' в навигаторе проекта"
echo "   • Выберите 'Add Files to SilverPulse'"
echo "   • Выберите папки: Models, Services, ViewModels, Views"
echo "   • Убедитесь, что target 'SilverPulse' отмечен галочкой"
echo "   • Нажмите 'Add'"
echo ""
echo "3. Или перетащите папки из Finder в Xcode:"
echo "   • Откройте Finder: /Users/dmitry/silver_pulse/SilverPulse/"
echo "   • Перетащите папки Models, Services, ViewModels, Views в Xcode"
echo ""
echo "4. После добавления файлов:"
echo "   • Соберите проект: ⌘+B"
echo "   • Запустите приложение: ⌘+R"
echo ""
echo "📖 Подробная инструкция: ADD_ALL_FILES_TO_XCODE.md"
echo ""
echo "🚀 После исправления запустите:"
echo "   ./launch_silver_pulse.sh"

echo ""
echo "=========================================="
echo "🏁 Скрипт завершен"