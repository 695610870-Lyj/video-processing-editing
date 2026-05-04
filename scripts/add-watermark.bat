@echo off
chcp 65001 >nul
:: Add Watermark to Video
:: Usage: add-watermark.bat input.mp4 watermark.png [position]
:: Positions: topleft, topright, bottomleft, bottomright, center

set "input=%~1"
set "watermark=%~2"
set "position=%~3"

if "%input%"=="" (
    echo Usage: add-watermark.bat input.mp4 watermark.png [position]
    exit /b 1
)

if "%position%"=="" set "position=bottomright"

set "output=%~dpn1_watermarked%~x1"

if "%position%"=="topleft" (
    set "overlay=10:10"
) else if "%position%"=="topright" (
    set "overlay=W-w-10:10"
) else if "%position%"=="bottomleft" (
    set "overlay=10:H-h-10"
) else if "%position%"=="bottomright" (
    set "overlay=W-w-10:H-h-10"
) else if "%position%"=="center" (
    set "overlay=(W-w)/2:(H-h)/2"
) else (
    set "overlay=W-w-10:H-h-10"
)

ffmpeg -i "%input%" -i "%watermark%" -filter_complex "[1:v]format=rgba,colorchannelmixer=aa=0.7[wm];[0:v][wm]overlay=%overlay%" -c:a copy "%output%"
echo Watermarked: %output%
