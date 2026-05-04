@echo off
chcp 65001 >nul
:: Extract Frames from Video
:: Usage: extract-frames.bat input.mp4 [fps] [output_dir]

set "input=%~1"
set "fps=%~2"
set "outdir=%~3"

if "%input%"=="" (
    echo Usage: extract-frames.bat input.mp4 [fps] [output_dir]
    exit /b 1
)

if "%fps%"=="" set "fps=1"
if "%outdir%"=="" set "outdir=frames_%fps%fps"

mkdir "%outdir%" 2>nul
ffmpeg -i "%input%" -vf "fps=%fps%,scale=1920:-1:flags=lanczos" "%outdir%\frame_%%04d.png"
echo Frames extracted to: %outdir%
