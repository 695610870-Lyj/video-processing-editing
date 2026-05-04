@echo off
chcp 65001 >nul
:: Batch Video Processor
:: Usage: batch-process.bat "*.mp4" operation [params]
:: Operations: compress, resize720, resize1080, mute, extractaudio, gif

set "pattern=%~1"
set "operation=%~2"

if "%pattern%"=="" (
    echo Usage: batch-process.bat "*.mp4" operation
    echo Operations: compress, resize720, resize1080, mute, extractaudio, gif
    exit /b 1
)

for %%f in (%pattern%) do (
    echo Processing: %%f
    
    if "%operation%"=="compress" (
        ffmpeg -i "%%f" -c:v libx264 -preset medium -crf 28 -c:a aac -b:a 128k -movflags +faststart "compressed_%%~nxf"
    ) else if "%operation%"=="resize720" (
        ffmpeg -i "%%f" -vf "scale=1280:720" -c:v libx264 -preset fast -crf 23 -c:a copy "720p_%%~nxf"
    ) else if "%operation%"=="resize1080" (
        ffmpeg -i "%%f" -vf "scale=1920:1080" -c:v libx264 -preset fast -crf 23 -c:a copy "1080p_%%~nxf"
    ) else if "%operation%"=="mute" (
        ffmpeg -i "%%f" -c copy -an "muted_%%~nxf"
    ) else if "%operation%"=="extractaudio" (
        ffmpeg -i "%%f" -vn -c:a libmp3lame -q:a 2 "%%~nf.mp3"
    ) else if "%operation%"=="gif" (
        ffmpeg -i "%%f" -vf "fps=10,scale=480:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=128[p];[s1][p]paletteuse" "%%~nf.gif"
    ) else (
        echo Unknown operation: %operation%
        exit /b 1
    )
)

echo Batch processing complete!
