#!/usr/bin/env python3
"""Remove hook from .claude/settings.json"""

import json
import sys
from pathlib import Path

def main():
    if len(sys.argv) != 2:
        print("Usage: projecthookrm.py <hook-name>")
        return 1
    
    hook_name = sys.argv[1]
    
    settings_file = Path(".claude/settings.json")
    if not settings_file.exists():
        print("No .claude/settings.json found")
        return 1
    
    # Load settings
    with open(settings_file) as f:
        settings = json.load(f)
    
    if "hooks" not in settings:
        print("No hooks configured")
        return 1
    
    # Find and remove the hook
    removed = False
    for trigger, hook_list in settings["hooks"].items():
        for i, hook_config in enumerate(hook_list):
            for hook in hook_config.get("hooks", []):
                if f"~/.claude/hooks/{hook_name}.sh" in hook.get("command", ""):
                    hook_list.pop(i)
                    removed = True
                    print(f"Removed hook '{hook_name}' from trigger '{trigger}'")
                    break
            if removed:
                break
        if removed:
            # Clean up empty trigger lists
            if not hook_list:
                del settings["hooks"][trigger]
            break
    
    if not removed:
        print(f"Hook '{hook_name}' not found in .claude/settings.json")
        return 1
    
    # Write back
    with open(settings_file, 'w') as f:
        json.dump(settings, f, indent=2)

if __name__ == "__main__":
    exit(main())