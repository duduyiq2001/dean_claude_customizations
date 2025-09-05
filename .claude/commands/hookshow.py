#!/usr/bin/env python3
"""Show all available hooks from global settings"""

import json
import os
from pathlib import Path

def main():
    global_settings = Path.home() / ".claude" / "settings.json"
    
    if not global_settings.exists():
        print(f"No global settings found at {global_settings}")
        return 1
    
    try:
        with open(global_settings) as f:
            settings = json.load(f)
        
        hooks = settings.get("hooks", {})
        
        print("Available Hooks (Global):")
        print("========================")
        
        if not hooks:
            print("No hooks configured in global settings")
            return 0
        
        for hook_name, hook_config in hooks.items():
            print(f"{hook_name}: {hook_config}")
            
    except (json.JSONDecodeError, FileNotFoundError) as e:
        print(f"Error reading global settings: {e}")
        return 1

if __name__ == "__main__":
    exit(main())