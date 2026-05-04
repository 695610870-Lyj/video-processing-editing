@echo off
chcp 65001 >nul
:: Change Video Speed
:: Usage: speed.bat input.mp4 speed_factor [output.mp4]
:: speed_factor: 0.5 = half speed, 2.0 = double speed

set "input=%~1"
set "speed=%~2"
set "output=%~3"

if "%input%"=="" (
    echo Usage: speed.bat input.mp4 speed_factor
    echo Example: speed.bat video.mp4 2.0
    exit /b 1
)

if "%speed%"=="" set "speed=2.0"
if "%output%"=="" set "output=%~dpn1_%.speed%x%~x1"

set /a "pts=100 * 100 / (%speed% * 100)"

ffmpeg -i "%input%" -filter_complex "[0:v]setpts=%speed%*PTS[v];[0:a]atempo=%speed%[a]" -map "[v]" -map "[a]" -c:v libx264 -preset fast -crf 23 "%output%"

echo Speed changed: %output%
