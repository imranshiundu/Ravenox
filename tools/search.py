import sys
import json
import os
from tavily import TavilyClient
from dotenv import load_dotenv

load_dotenv()

def main():
    api_key = os.getenv("TAVILY_API_KEY")
    if not api_key:
        print(json.dumps({"error": "TAVILY_API_KEY not found in environment"}))
        return

    if len(sys.argv) < 2:
        print(json.dumps({"error": "No query provided"}))
        return

    query = sys.argv[1]
    tavily = TavilyClient(api_key=api_key)
    
    # Perform AI-optimized search
    response = tavily.search(query=query, search_depth="advanced", max_results=5)
    
    # Format results as clean markdown/json
    print(json.dumps(response))

if __name__ == "__main__":
    main()
