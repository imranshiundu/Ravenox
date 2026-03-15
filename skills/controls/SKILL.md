---
name: controls
description: Local desktop and application controls. Open Spotify, VS Code, or manage system volume.
metadata:
  {
    "openclaw":
      {
        "emoji": "🎛️",
        "requires": { "bins": ["xdg-open", "pactl"] },
      },
  }
---

# Local Controls (The Menu Mode)

This skill provides direct, non-automated commands to control your local machine. It functions like a "Menu" of available tasks.

## Available Commands

- **Open Spotify**: `arthur control spotify`
- **Open Code Editor**: `arthur control code`
- **Screenshot**: `arthur control screenshot`
- **System Info**: `arthur control info`

## Usage Examples

### 1. Open Spotify and Play Music
The agent uses `xdg-open` (on Linux) or `open` (on macOS) to trigger Spotify.
```bash
# Internal tool logic
xdg-open "spotify:track:4cOdK9sS2Z67GI9G36YI9U" # Example track
```

### 2. Manual Navigation
Say "Open my project in VS Code"
```bash
code .
```

## Task Selection Logic
When you ask Arthur "What can you do?", it will present this menu:
1. 🎵 **Spotify**: Control music playback.
2. 💻 **VS Code**: Open editors and projects.
3. 📸 **Screen**: Take and analyze screenshots.
4. 🔋 **System**: Check battery, CPU, and RAM.
