@echo off
chcp 65001 >nul
:: Video Trimmer
:: Usage: trim.bat input.mp4 output.mp4 start_time duration
:: Time format: HH:MM:SS or seconds

set "input=%~1"
set "output=%~2"
set "start=%~3"
set "duration=%~4"

if "%input%"=="" (
    echo Usage: trim.bat input.mp4 output.mp4 start_time duration
    echo Example: trim.bat video.mp4 clip.mp4 00:01:30 60
    exit /b 1
)

ffmpeg -i "%input%" -ss "%start%" -t "%duration%" -c copy "%output%"
echo Trimmed: %output%
