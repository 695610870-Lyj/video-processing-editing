@echo off
chcp 65001 >nul
:: Video Format Converter
:: Usage: convert.bat input.ext output.ext [quality]

set "input=%~1"
set "output=%~2"
set "quality=%~3"

if "%input%"=="" (
    echo Usage: convert.bat input.ext output.ext [quality:low/medium/high]
    exit /b 1
)

if "%output%"=="" (
    echo Usage: convert.bat input.ext output.ext [quality:low/medium/high]
    exit /b 1
)

if "%quality%"=="" set "quality=medium"

if "%quality%"=="low" (
    ffmpeg -i "%input%" -c:v libx264 -preset fast -crf 28 -c:a aac -b:a 128k "%output%"
) else if "%quality%"=="medium" (
    ffmpeg -i "%input%" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 192k "%output%"
) else if "%quality%"=="high" (
    ffmpeg -i "%input%" -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 256k "%output%"
) else (
    echo Unknown quality: %quality%. Using medium.
    ffmpeg -i "%input%" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 192k "%output%"
)

echo Done: %output%
