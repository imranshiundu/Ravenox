import sys
import json
import pyautogui
import mss
import os
from datetime import datetime

def main():
    if len(sys.argv) < 2:
        print(json.dumps({"error": "No command provided"}))
        return

    cmd = sys.argv[1]
    
    # Ensure a screenshots directory exists
    os.makedirs("data/screenshots", exist_ok=True)

    if cmd == "screenshot":
        with mss.mss() as sct:
            filename = f"data/screenshots/screen_{datetime.now().strftime('%Y%m%d_%H%M%S')}.png"
            sct.shot(output=filename)
            print(json.dumps({"status": "success", "file": filename}))

    elif cmd == "click":
        if len(sys.argv) < 4:
            print(json.dumps({"error": "X and Y coordinates required"}))
            return
        x, y = int(sys.argv[2]), int(sys.argv[3])
        pyautogui.click(x, y)
        print(json.dumps({"status": "success", "action": "click", "coords": [x, y]}))

    elif cmd == "type":
        if len(sys.argv) < 3:
            print(json.dumps({"error": "Text required"}))
            return
        text = sys.argv[2]
        pyautogui.write(text)
        print(json.dumps({"status": "success", "action": "type", "text": text}))

    elif cmd == "info":
        width, height = pyautogui.size()
        pos = pyautogui.position()
        print(json.dumps({
            "screen_size": [width, height],
            "mouse_position": [pos.x, pos.y]
        }))

if __name__ == "__main__":
    main()
