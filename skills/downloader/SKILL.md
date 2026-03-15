---
name: downloader
description: Download media (video, audio, images) from social media links (YouTube, Instagram, TikTok, Facebook, Pinterest, etc.) using yt-dlp.
metadata:
  {
    "arthur":
      {
        "emoji": "📥",
        "requires": { "bins": ["yt-dlp", "ffmpeg"] },
        "install":
          [
            {
              "id": "brew",
              "kind": "brew",
              "formula": "yt-dlp",
              "bins": ["yt-dlp"],
              "label": "Install yt-dlp (brew)",
            },
            {
              "id": "apt",
              "kind": "apt",
              "package": "yt-dlp",
              "bins": ["yt-dlp"],
              "label": "Install yt-dlp (apt)",
            },
          ],
      },
  }
---

# Downloader

Use this skill to fetch media from links provided by the user. It supports almost every major social platform.

## When to use

- When a user sends a link and asks to "download", "fetch", "save", or "get" the video/audio.
- When you need to process the content of a social media video locally.

## Features

- **Video Download**: Get the highest quality video.
- **Audio Extraction**: Extract MP3/M4A from video links.
- **Batch mode**: Supports multiple URLs.

## Usage

```bash
# Download video
yt-dlp "https://www.youtube.com/watch?v=..." -o "/path/to/save/%(title)s.%(ext)s"

# Extract audio only
yt-dlp -x --audio-format mp3 "https://tiktok.com/@user/video/..." -o "/path/to/save/%(title)s.mp3"
```

## Security

- Ensure the download path is within the approved workspace.
- Do not download files from untrusted sources without scanning if possible.
