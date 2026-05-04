@echo off
chcp 65001 >nul
:: Convert Video to GIF
:: Usage: to-gif.bat input.mp4 [start_time] [duration] [fps] [width]

set "input=%~1"
set "start=%~2"
set "duration=%~3"
set "fps=%~4"
set "width=%~5"

if "%input%"=="" (
    echo Usage: to-gif.bat input.mp4 [start] [duration] [fps] [width]
    exit /b 1
)

set "output=%~dpn1.gif"

set "ss="
set "t="
set "vf=fps="

if not "%start%"=="" set "ss=-ss %start%"
if not "%duration%"=="" set "t=-t %duration%"
if "%fps%"=="" set "fps=15"
if "%width%"=="" set "width=480"

ffmpeg -i "%input%" %ss% %t% -vf "fps=%fps%,scale=%width%:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse=dither=bayer" -loop 0 "%output%"

echo GIF created: %output%
