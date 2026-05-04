@echo off
chcp 65001 >nul
:: Video Compressor
:: Usage: compress.bat input.mp4 [crf] [preset]

set "input=%~1"
set "crf=%~2"
set "preset=%~3"

if "%input%"=="" (
    echo Usage: compress.bat input.mp4 [crf:18-35] [preset:fast/medium/slow]
    exit /b 1
)

if "%crf%"=="" set "crf=28"
if "%preset%"=="" set "preset=medium"

set "output=%~dpn1_compressed%~x1"

ffmpeg -i "%input%" -c:v libx264 -preset %preset% -crf %crf% -c:a aac -b:a 128k -movflags +faststart "%output%"
echo Compressed: %output%
