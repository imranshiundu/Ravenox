import os
import subprocess
import sys

def start_proxy():
    # This script starts the LiteLLM proxy as a background process
    # It assumes a config.yaml exists or uses env vars
    print("Starting LiteLLM Proxy on http://localhost:4000")
    
    # Example command: litellm --model gpt-3.5-turbo
    # In production, we'd use a config file
    try:
        subprocess.Popen(["litellm", "--port", "4000"])
        print("LiteLLM Proxy started.")
    except Exception as e:
        print(f"Failed to start LiteLLM: {e}")

if __name__ == "__main__":
    start_proxy()
