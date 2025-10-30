#!/bin/sh

# Каталог с видео-обоями
WALLPAPER_DIR="$HOME/Видео/Обои"

# Имя файла передаётся как первый аргумент ($1)
VIDEO_FILE="$1"

# Проверка, был ли передан аргумент
if [ -z "$VIDEO_FILE" ]; then
    echo "Ошибка: не указано имя видеофайла."
    exit 1
fi

# Получение имени активного (фокусированного) монитора
MONITOR=$(niri msg --json outputs | jq -r '.[] | select(.focused == true) | .name')

# Убить предыдущий процесс mpvpaper
pkill mpvpaper

# Запустить новый процесс mpvpaper с указанным видео
nohup mpvpaper "$MONITOR" "$WALLPAPER_DIR/$VIDEO_FILE" -o "--loop --no-audio" &>/dev/null &
