@echo off
chcp 65001 >nul
:: Get Video Information
:: Usage: video-info.bat input.mp4

set "input=%~1"

if "%input%"=="" (
    echo Usage: video-info.bat input.mp4
    exit /b 1
)

echo === Video Information ===
echo File: %input%
echo.
ffprobe -v error -show_entries format=duration -of "default=noprint_wrappers=1:nokey=1" "%input%"
set /p duration=<nul

echo Duration: 
ffprobe -v error -show_entries format=duration -of "default=noprint_wrappers=1:nokey=1" "%input%"

echo Resolution: 
ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of "csv=s=x:p=0" "%input%"

echo Video Codec: 
ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of "default=noprint_wrappers=1:nokey=1" "%input%"

echo Audio Codec: 
ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of "default=noprint_wrappers=1:nokey=1" "%input%"

echo Frame Rate: 
ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of "default=noprint_wrappers=1:nokey=1" "%input%"

echo Bitrate: 
ffprobe -v error -show_entries format=bit_rate -of "default=noprint_wrappers=1:nokey=1" "%input%"

echo.
echo === Full Metadata ===
ffprobe -v quiet -print_format json -show_format -show_streams "%input%"
