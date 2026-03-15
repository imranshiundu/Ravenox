import sys
import json
from mem0 import Memory
import os
from dotenv import load_dotenv

load_dotenv()

def main():
    if len(sys.argv) < 2:
        print(json.dumps({"error": "No command provided"}))
        return

    cmd = sys.argv[1]
    
    # Initialize Mem0
    # Note: requires MEM0_API_KEY if using cloud, or local setup
    config = {
        "vector_store": {
            "provider": "qdrant",
            "config": {
                "host": "localhost",
                "port": 6333,
            }
        }
    }
    
    # Default to local if no API key
    if os.getenv("MEM0_API_KEY"):
        m = Memory()
    else:
        m = Memory.from_config(config)

    if cmd == "add":
        data = sys.argv[2]
        user_id = sys.argv[3] if len(sys.argv) > 3 else "default_user"
        result = m.add(data, user_id=user_id)
        print(json.dumps(result))

    elif cmd == "search":
        query = sys.argv[2]
        user_id = sys.argv[3] if len(sys.argv) > 3 else "default_user"
        result = m.search(query, user_id=user_id)
        print(json.dumps(result))

    elif cmd == "history":
        user_id = sys.argv[2] if len(sys.argv) > 1 else "default_user"
        result = m.history(user_id=user_id)
        print(json.dumps(result))

if __name__ == "__main__":
    main()
