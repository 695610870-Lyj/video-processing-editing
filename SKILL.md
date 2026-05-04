---
name: video-processing-editing
description: Video processing and editing tools - transcode, trim, extract frames, add subtitles, and convert formats using FFmpeg.
---

# Video Processing & Editing

Process and edit videos using FFmpeg and other tools.

## When to use

Use this skill when you need to:
- Transcode videos between formats (MP4, AVI, MOV, etc.)
- Trim or cut video clips
- Extract frames from videos
- Add subtitles or watermarks
- Resize or change resolution
- Analyze video metadata
- Batch process multiple videos

## Tools

This skill uses FFmpeg for video processing operations.

## Examples

### Transcode video
```bash
ffmpeg -i input.avi -c:v libx264 -c:a aac output.mp4
```

### Extract frames
```bash
ffmpeg -i input.mp4 -vf "fps=1" frame_%04d.png
```

### Trim video
```bash
ffmpeg -i input.mp4 -ss 00:01:00 -t 30 -c copy output.mp4
```
