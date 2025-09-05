#!/usr/bin/env python3
"""Show hooks from .claude/settings.local.json"""

import json
from pathlib import Path

def main():
    settings_file = Path(".claude/settings.local.json")
    
    if not settings_file.exists():
        print("No .claude/settings.local.json found")
        return 0
    
    try:
        with open(settings_file) as f:
            settings = json.load(f)
        
        hooks = settings.get("hooks", {})
        
        print("Local Project Hooks (.claude/settings.local.json):")
        print("==================================================")
        
        if not hooks:
            print("No hooks configured")
            return 0
        
        for hook_name, hook_config in hooks.items():
            print(f"{hook_name}: {hook_config}")
            
    except (json.JSONDecodeError, FileNotFoundError) as e:
        print(f"Error reading settings: {e}")
        return 1

if __name__ == "__main__":
    exit(main())