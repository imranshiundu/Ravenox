---
name: sticker
description: Convert images and short videos into stickers for WhatsApp, Telegram, and Discord.
metadata:
  {
    .ravenox":
      {
        "emoji": "🎨",
        "requires": { "bins": ["ffmpeg", "convert"] },
        "install":
          [
            {
              "id": "brew",
              "kind": "brew",
              "formula": "imagemagick ffmpeg",
              "bins": ["convert", "ffmpeg"],
              "label": "Install ImageMagick and FFmpeg",
            },
          ],
      },
  }
---

# Sticker Maker

Use this skill to create stickers from user-provided media.

## When to use

- When a user asks to "make a sticker", "convert to sticker", or "stickerize this".
- Supports images (PNG, JPG, WebP) and short videos/GIFs.

## Usage

### Static Sticker (Image)
```bash
ffmpeg -i input.jpg -vf "scale=512:512:force_original_aspect_ratio=decrease,pad=512:512:(ow-iw)/2:(oh-ih)/2:color=#00000000" output.webp
```

### Animated Sticker (Video/GIF)
```bash
ffmpeg -i input.mp4 -vcodec libwebp -filter:v "fps=fps=20,scale=512:512:force_original_aspect_ratio=decrease,pad=512:512:(ow-iw)/2:(oh-ih)/2:color=#00000000" -loop 0 -preset default -an -vsync 0 output.webp
```

## Requirements
- Output MUST be WebP format.
- Size MUST be 512x512 pixels for platform compatibility.
- Duration should be under 6 seconds for animated stickers.
