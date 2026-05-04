@echo off
chcp 65001 >nul
:: Merge Multiple Videos
:: Usage: merge-videos.bat output.mp4 input1.mp4 input2.mp4 [input3.mp4 ...]

set "output=%~1"
shift

if "%output%"=="" (
    echo Usage: merge-videos.bat output.mp4 input1.mp4 input2.mp4 ...
    exit /b 1
)

:: Create temp file list
set "listfile=%TEMP%\merge_list_%RANDOM%.txt"
del "%listfile%" 2>nul

:loop
if "%~1"=="" goto :done
echo file '%~1' >> "%listfile%"
shift
goto :loop

:done
if not exist "%listfile%" (
    echo No input files provided
    exit /b 1
)

ffmpeg -f concat -safe 0 -i "%listfile%" -c copy "%output%"
del "%listfile%"

echo Merged: %output%
