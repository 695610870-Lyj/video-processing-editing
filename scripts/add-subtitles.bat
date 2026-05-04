@echo off
chcp 65001 >nul
:: Hardcode Subtitles into Video
:: Usage: add-subtitles.bat input.mp4 subtitles.srt [output.mp4]

set "input=%~1"
set "subtitles=%~2"
set "output=%~3"

if "%input%"=="" (
    echo Usage: add-subtitles.bat input.mp4 subtitles.srt [output.mp4]
    exit /b 1
)

if "%output%"=="" set "output=%~dpn1_subtitled%~x1"

ffmpeg -i "%input%" -vf "subtitles='%subtitles%'" -c:a copy "%output%"

echo Subtitled: %output%
