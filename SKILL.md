---
name: video-processing-editing
description: Video processing and editing tools - transcode, trim, extract frames, add subtitles, watermarks, effects, transitions, audio processing, batch export, GIF/thumbnail generation, speed control, color correction, compression, splitting/merging, and format conversion using FFmpeg.
---

# Video Processing & Editing

Comprehensive video processing and editing using FFmpeg and other tools.

## When to use

Use this skill when you need to:
- Transcode videos between formats (MP4, AVI, MOV, MKV, WebM, etc.)
- Trim, cut, or split video clips
- Merge multiple videos into one
- Extract frames or generate thumbnails
- Add subtitles (hardcode or extract)
- Add watermarks or text overlays
- Apply video effects and transitions
- Adjust video speed (slow motion / time-lapse)
- Color correction and filters
- Audio extraction, replacement, or mixing
- Video compression and optimization
- Batch process multiple videos
- Generate GIFs from video
- Analyze video metadata
- Change resolution or aspect ratio
- Rotate or flip videos

## Requirements

- FFmpeg installed and available in PATH
- For advanced effects: ffprobe (usually bundled with FFmpeg)

## Core Operations

### Format Conversion / Transcode
```bash
# MP4 (H.264 + AAC)
ffmpeg -i input.avi -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 192k output.mp4

# MP4 (H.265/HEVC - better compression)
ffmpeg -i input.mp4 -c:v libx265 -preset medium -crf 28 -c:a copy output_hevc.mp4

# WebM (VP9)
ffmpeg -i input.mp4 -c:v libvpx-vp9 -b:v 1M -c:a libopus output.webm

# MOV (ProRes for editing)
ffmpeg -i input.mp4 -c:v prores_ks -profile:v 3 -c:a pcm_s16le output.mov

# AVI
ffmpeg -i input.mp4 -c:v libxvid -qscale:v 3 -c:a libmp3lame -qscale:a 3 output.avi

# MKV
ffmpeg -i input.mp4 -c copy output.mkv

# Extract audio only
ffmpeg -i input.mp4 -vn -c:a libmp3lame -q:a 2 output.mp3
ffmpeg -i input.mp4 -vn -c:a copy output.aac
```

### Trim / Cut
```bash
# Trim from start time for duration
ffmpeg -i input.mp4 -ss 00:01:30 -t 60 -c copy output.mp4

# Trim from start to end time
ffmpeg -i input.mp4 -ss 00:01:30 -to 00:02:30 -c copy output.mp4

# Trim multiple segments (concatenate later)
ffmpeg -i input.mp4 -ss 10 -t 20 -c copy segment1.mp4
ffmpeg -i input.mp4 -ss 40 -t 30 -c copy segment2.mp4
```

### Merge / Concatenate
```bash
# Create file list
echo "file 'video1.mp4'" > list.txt
echo "file 'video2.mp4'" >> list.txt
echo "file 'video3.mp4'" >> list.txt

# Concatenate (same codec)
ffmpeg -f concat -safe 0 -i list.txt -c copy output.mp4

# Concatenate with re-encoding (different formats/codecs)
ffmpeg -f concat -safe 0 -i list.txt -c:v libx264 -preset fast -crf 23 -c:a aac output.mp4
```

### Extract Frames / Thumbnails
```bash
# Extract 1 frame per second
ffmpeg -i input.mp4 -vf "fps=1" frame_%04d.png

# Extract frame at specific time
ffmpeg -i input.mp4 -ss 00:05:00 -vframes 1 thumbnail.png

# Generate thumbnail grid (contact sheet)
ffmpeg -i input.mp4 -vf "select='not(mod(n\,100))',scale=320:180,tile=4x4" -frames:v 1 contact_sheet.jpg

# Extract all frames (uncompressed)
ffmpeg -i input.mp4 frame_%06d.png
```

### Resize / Resolution
```bash
# Scale to specific width (height auto)
ffmpeg -i input.mp4 -vf "scale=1920:-2" output.mp4

# Scale to specific height (width auto)
ffmpeg -i input.mp4 -vf "scale=-2:1080" output.mp4

# Scale to exact resolution
ffmpeg -i input.mp4 -vf "scale=1920:1080" output.mp4

# Scale with padding (maintain aspect ratio)
ffmpeg -i input.mp4 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black" output.mp4

# Downscale for mobile
ffmpeg -i input.mp4 -vf "scale=720:-2" -c:v libx264 -preset fast -crf 28 -c:a aac -b:a 128k mobile.mp4
```

### Rotate / Flip
```bash
# Rotate 90 degrees clockwise
ffmpeg -i input.mp4 -vf "transpose=1" output.mp4

# Rotate 90 degrees counter-clockwise
ffmpeg -i input.mp4 -vf "transpose=2" output.mp4

# Rotate 180 degrees
ffmpeg -i input.mp4 -vf "transpose=2,transpose=2" output.mp4

# Flip horizontally
ffmpeg -i input.mp4 -vf "hflip" output.mp4

# Flip vertically
ffmpeg -i input.mp4 -vf "vflip" output.mp4
```

## Effects & Filters

### Color Correction
```bash
# Brightness and contrast
ffmpeg -i input.mp4 -vf "eq=brightness=0.1:contrast=1.2" output.mp4

# Saturation
ffmpeg -i input.mp4 -vf "eq=saturation=1.5" output.mp4

# Gamma correction
ffmpeg -i input.mp4 -vf "eq=gamma=1.2" output.mp4

# Combined color adjustment
ffmpeg -i input.mp4 -vf "eq=brightness=0.05:contrast=1.1:saturation=1.2:gamma=1.1" output.mp4

# Fade in/out
ffmpeg -i input.mp4 -vf "fade=t=in:st=0:d=2,fade=t=out:st=28:d=2" output.mp4
```

### Blur & Sharpen
```bash
# Gaussian blur
ffmpeg -i input.mp4 -vf "gblur=sigma=2" output.mp4

# Box blur
ffmpeg -i input.mp4 -vf "boxblur=2:1" output.mp4

# Sharpen
ffmpeg -i input.mp4 -vf "unsharp=5:5:1.0:5:5:0.0" output.mp4
```

### Video Effects
```bash
# Black and white
ffmpeg -i input.mp4 -vf "hue=s=0" output.mp4

# Sepia tone
ffmpeg -i input.mp4 -vf "colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131" output.mp4

# Vintage film look
ffmpeg -i input.mp4 -vf "curves=r='0/0.11 .42/.51 1/0.95':g='0/0 1/1':b='0/0 .25/.4 .49/.51 1/1'" output.mp4

# Vignette
ffmpeg -i input.mp4 -vf "vignette=PI/4" output.mp4

# Noise reduction
ffmpeg -i input.mp4 -vf "hqdn3d=4:3:6:4" output.mp4
```

### Transitions
```bash
# Crossfade between two videos (using filter_complex)
ffmpeg -i video1.mp4 -i video2.mp4 -filter_complex \
"[0:v]fade=t=out:st=4:d=1:alpha=1[va0];[1:v]fade=t=in:st=0:d=1:alpha=1[va1];[va0][va1]overlay[fv];[0:a]afade=t=out:st=4:d=1[aa0];[1:a]afade=t=in:st=0:d=1[aa1];[aa0][aa1]amix=inputs=2[fa]" \
-map "[fv]" -map "[fa]" -c:v libx264 -preset fast -crf 23 -c:a aac output.mp4
```

## Speed Control

```bash
# Slow motion (0.5x speed)
ffmpeg -i input.mp4 -filter_complex "[0:v]setpts=2.0*PTS[v];[0:a]atempo=0.5[a]" -map "[v]" -map "[a]" output.mp4

# Time-lapse (2x speed)
ffmpeg -i input.mp4 -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" output.mp4

# Speed up video only (mute audio)
ffmpeg -i input.mp4 -vf "setpts=0.25*PTS" -an output.mp4

# Slow motion with smooth motion (frame interpolation)
ffmpeg -i input.mp4 -vf "minterpolate='mi_mode=mci:mc_mode=aobmc:vsbmc=1:fps=60',setpts=2.0*PTS" -c:v libx264 -preset slow -crf 18 output.mp4
```

## Audio Processing

```bash
# Extract audio
ffmpeg -i input.mp4 -vn -c:a copy audio.aac
ffmpeg -i input.mp4 -vn -c:a libmp3lame -q:a 2 audio.mp3
ffmpeg -i input.mp4 -vn -c:a flac audio.flac

# Remove audio
ffmpeg -i input.mp4 -c copy -an output.mp4

# Replace audio track
ffmpeg -i video.mp4 -i new_audio.mp3 -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest output.mp4

# Mix audio tracks
ffmpeg -i video.mp4 -i music.mp3 -filter_complex "[0:a][1:a]amix=inputs=2:duration=first:dropout_transition=3[a]" -map 0:v -map "[a]" -c:v copy -c:a aac output.mp4

# Adjust volume
ffmpeg -i input.mp4 -af "volume=1.5" output.mp4
ffmpeg -i input.mp4 -af "volume=0.5" output.mp4

# Normalize audio
ffmpeg -i input.mp4 -af "loudnorm=I=-16:TP=-1.5:LRA=11" -c:v copy output.mp4

# Remove background noise
ffmpeg -i input.mp4 -af "afftdn=nf=-25" -c:v copy output.mp4

# Add audio fade in/out
ffmpeg -i input.mp4 -af "afade=t=in:st=0:d=2,afade=t=out:st=28:d=2" -c:v copy output.mp4
```

## Subtitles

```bash
# Hardcode subtitles (burn into video)
ffmpeg -i input.mp4 -vf "subtitles=subtitle.srt" -c:a copy output.mp4

# Hardcode with custom font and style
ffmpeg -i input.mp4 -vf "subtitles=subtitle.srt:force_style='FontName=Arial,FontSize=24,PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000,BackColour=&H80000000,Bold=1,Outline=2,Shadow=2,Alignment=2'" -c:a copy output.mp4

# Extract subtitles to SRT
ffmpeg -i input.mp4 -map 0:s:0 subtitle.srt

# Add subtitles as separate stream (soft subtitle)
ffmpeg -i input.mp4 -i subtitle.srt -c copy -c:s mov_text output.mp4

# Multiple subtitle tracks
ffmpeg -i input.mp4 -i chinese.srt -i english.srt -map 0 -map 1 -map 2 -c:v copy -c:a copy -c:s srt output.mkv
```

## Watermarks & Overlays

```bash
# Image watermark (bottom-right corner)
ffmpeg -i input.mp4 -i watermark.png -filter_complex "[0:v][1:v]overlay=W-w-10:H-h-10" -c:a copy output.mp4

# Image watermark with transparency
ffmpeg -i input.mp4 -i watermark.png -filter_complex "[1:v]format=rgba,colorchannelmixer=aa=0.5[wm];[0:v][wm]overlay=W-w-10:H-h-10" -c:a copy output.mp4

# Text watermark
ffmpeg -i input.mp4 -vf "drawtext=text='Copyright 2024':x=10:y=H-th-10:fontsize=24:fontcolor=white:box=1:boxcolor=black@0.5" -c:a copy output.mp4

# Centered text overlay
ffmpeg -i input.mp4 -vf "drawtext=text='Sample Text':x=(w-text_w)/2:y=(h-text_h)/2:fontsize=48:fontcolor=yellow:box=1:boxcolor=black@0.7" -c:a copy output.mp4

# Scrolling text
ffmpeg -i input.mp4 -vf "drawtext=text='Scrolling...':x=w-mod(50*t\,w+text_w):y=30:fontsize=36:fontcolor=white" -c:a copy output.mp4

# Picture-in-picture
ffmpeg -i main.mp4 -i pip.mp4 -filter_complex "[1:v]scale=iw/4:-1[small];[0:v][small]overlay=W-w-10:10" -c:a copy output.mp4

# Logo overlay with fade
ffmpeg -i input.mp4 -i logo.png -filter_complex "[1:v]fade=t=in:st=0:d=1:alpha=1,format=rgba,colorchannelmixer=aa=0.7[logo];[0:v][logo]overlay=W-w-20:20" -c:a copy output.mp4
```

## Compression & Optimization

```bash
# Compress for web (good balance)
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 28 -c:a aac -b:a 128k -movflags +faststart web.mp4

# Compress for mobile
ffmpeg -i input.mp4 -c:v libx264 -preset medium -crf 30 -c:a aac -b:a 96k -vf "scale=720:-2" mobile.mp4

# Compress with HEVC/H.265 (smaller file)
ffmpeg -i input.mp4 -c:v libx265 -preset medium -crf 30 -c:a aac -b:a 128k hevc.mp4

# Two-pass encoding (better quality at target bitrate)
ffmpeg -i input.mp4 -c:v libx264 -preset medium -b:v 1000k -pass 1 -an -f null /dev/null
ffmpeg -i input.mp4 -c:v libx264 -preset medium -b:v 1000k -pass 2 -c:a aac -b:a 128k output.mp4

# Optimize for streaming (fast start)
ffmpeg -i input.mp4 -c copy -movflags +faststart streamable.mp4

# Compress GIF-like video (looping, no audio)
ffmpeg -i input.mp4 -an -c:v libx264 -preset fast -crf 30 -vf "scale=480:-2:flags=lanczos" -movflags +faststart -pix_fmt yuv420p loop.mp4
```

## GIF Generation

```bash
# Convert video to GIF (basic)
ffmpeg -i input.mp4 -vf "fps=10,scale=480:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=128[p];[s1][p]paletteuse=dither=bayer" output.gif

# High quality GIF
ffmpeg -i input.mp4 -vf "fps=15,scale=480:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -loop 0 output.gif

# GIF with specific duration
ffmpeg -i input.mp4 -ss 5 -t 3 -vf "fps=20,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" output.gif

# Optimize GIF file size
ffmpeg -i input.mp4 -vf "fps=10,scale=360:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=64[p];[s1][p]paletteuse=bayer" -loop 0 small.gif
```

## Splitting & Segmenting

```bash
# Split into equal segments (10 seconds each)
ffmpeg -i input.mp4 -c copy -map 0 -segment_time 10 -f segment -reset_timestamps 1 segment_%03d.mp4

# Split at specific timestamps
ffmpeg -i input.mp4 -t 60 -c copy part1.mp4
ffmpeg -i input.mp4 -ss 60 -t 60 -c copy part2.mp4
ffmpeg -i input.mp4 -ss 120 -c copy part3.mp4

# Split by file size (e.g., 100MB per file)
ffmpeg -i input.mp4 -c copy -map 0 -f segment -segment_time 0 -segment_format mp4 -segment_list list.m3u8 -segment_list_type m3u8 "segment_%03d.mp4"
```

## Batch Processing

```bash
# Batch convert all MP4 to WebM
for f in *.mp4; do ffmpeg -i "$f" -c:v libvpx-vp9 -b:v 1M -c:a libopus "${f%.mp4}.webm"; done

# Batch resize all videos to 720p
for f in *.mp4; do ffmpeg -i "$f" -vf "scale=1280:720" -c:v libx264 -preset fast -crf 23 -c:a copy "resized_$f"; done

# Batch extract audio from all videos
for f in *.{mp4,avi,mov}; do ffmpeg -i "$f" -vn -c:a libmp3lame -q:a 2 "${f%.*}.mp3"; done

# Batch generate thumbnails
for f in *.mp4; do ffmpeg -i "$f" -ss 00:00:05 -vframes 1 "${f%.mp4}_thumb.jpg"; done

# Batch compress all videos
for f in *.mp4; do ffmpeg -i "$f" -c:v libx264 -preset medium -crf 28 -c:a aac -b:a 128k -movflags +faststart "compressed_$f"; done
```

## Metadata & Analysis

```bash
# Show video metadata
ffprobe -v quiet -print_format json -show_format -show_streams input.mp4

# Get duration
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 input.mp4

# Get resolution
ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 input.mp4

# Get frame rate
ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 input.mp4

# Get bitrate
ffprobe -v error -select_streams v:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 input.mp4

# Count frames
ffprobe -v error -select_streams v:0 -count_packets -show_entries stream=nb_read_packets -of csv=p=0 input.mp4

# Extract metadata to file
ffprobe -v quiet -print_format json -show_format -show_streams input.mp4 > metadata.json
```

## Advanced Workflows

### Stabilize Shaky Video
```bash
ffmpeg -i input.mp4 -vf "vidstabdetect=stepsize=6:shakiness=8:accuracy=9:result=transforms.trf" -f null -
ffmpeg -i input.mp4 -vf "vidstabtransform=input=transforms.trf:zoom=1:smoothing=30,unsharp=5:5:0.8:3:3:0.4" -c:v libx264 -preset medium -crf 23 -c:a copy stabilized.mp4
```

### Remove Black Bars
```bash
ffmpeg -i input.mp4 -vf "cropdetect=24:16:0" -f null -
# Use detected crop values, e.g. crop=1920:800:0:140
ffmpeg -i input.mp4 -vf "crop=1920:800:0:140" -c:a copy output.mp4
```

### Create Slideshow from Images
```bash
# 3 seconds per image
ffmpeg -framerate 1/3 -i img_%03d.jpg -c:v libx264 -r 30 -pix_fmt yuv420p -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black" slideshow.mp4

# With crossfade transition
ffmpeg -framerate 1/3 -i img_%03d.jpg -vf "zoompan=z='min(zoom+0.0015,1.5)':d=125,framerate=30:interp_start=0:interp_end=255:scene=100" -c:v libx264 -t 30 -pix_fmt yuv420p slideshow.mp4
```

### Screen Recording
```bash
# Record screen (Windows - requires gdigrab)
ffmpeg -f gdigrab -framerate 30 -i desktop -c:v libx264 -preset fast -crf 23 recording.mp4

# Record specific window/region
ffmpeg -f gdigrab -framerate 30 -offset_x 100 -offset_y 100 -video_size 1280x720 -i desktop -c:v libx264 -preset fast -crf 23 recording.mp4

# Record with audio
ffmpeg -f gdigrab -framerate 30 -i desktop -f dshow -i audio="Microphone" -c:v libx264 -preset fast -crf 23 -c:a aac recording.mp4
```

## Tips

- **CRF values**: Lower = higher quality, larger file. 18-23 is visually lossless, 23-28 is good quality, 28-35 is acceptable quality.
- **Presets**: ultrafast > superfast > veryfast > faster > fast > medium > slow > slower > veryslow. Slower = better compression.
- **Copy codec** (`-c copy`): Fastest, no quality loss, but can't change resolution or apply filters.
- **Two-pass encoding**: Best for target file size or bitrate constraints.
- **Faststart** (`-movflags +faststart`): Places metadata at start for web streaming.
- **Hardware acceleration** (if supported): Use `-c:v h264_nvenc` (NVIDIA), `-c:v h264_amf` (AMD), or `-c:v h264_qsv` (Intel) for faster encoding.
