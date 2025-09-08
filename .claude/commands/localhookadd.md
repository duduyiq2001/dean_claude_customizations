---
description: Add hook to local project settings (.claude/settings.local.json)
argument-hint: <hook-name>
allowed-tools: Bash
---

Add a hook to the current project's local settings (not committed to git).

RUN THIS PYTHON SCRIPT!!!!!!!! AND THEN SHOW ME THE EXACT OUTPUT

#!/usr/bin/env python3


"""
"Add hook to .claude/settings.local.json"

import json
import sys
from pathlib import Path

def main():
    if len(sys.argv) != 2:
        print("Usage: localhookadd.py <hook-name>")
        return 1
    
    hook_name = sys.argv[1]
    
    # Check if hook exists in global hooks directory
    hook_file = Path.home() / ".claude/hooks" / f"{hook_name}.sh"
    if not hook_file.exists():
        print(f"Hook '{hook_name}' not found in ~/.claude/hooks/")
        print("Available hooks:")
        hooks_dir = Path.home() / ".claude/hooks"
        if hooks_dir.exists():
            for hook in hooks_dir.glob("*.sh"):
                print(f"  {hook.stem}")
        return 1
    
    # Load hook rules from global location
    rules_file = Path.home() / ".claude/hook-rules.json"
    if not rules_file.exists():
        print("~/.claude/hook-rules.json not found")
        return 1
    
    with open(rules_file) as f:
        hook_rules = json.load(f)
    
    if hook_name not in hook_rules:
        print(f"No rules found for hook '{hook_name}'")
        return 1
    
    rule = hook_rules[hook_name]
    
    # Setup settings file
    settings_dir = Path(".claude")
    settings_file = settings_dir / "settings.local.json"
    settings_dir.mkdir(exist_ok=True)
    
    # Load existing settings
    settings = {}
    if settings_file.exists():
        with open(settings_file) as f:
            settings = json.load(f)
    
    # Initialize hooks section
    if "hooks" not in settings:
        settings["hooks"] = {}
    
    trigger = rule["trigger"]
    if trigger not in settings["hooks"]:
        settings["hooks"][trigger] = []
    
    # Create hook config
    hook_config = {
        "hooks": [
            {
                "type": "command", 
                "command": f"~/.claude/hooks/{hook_name}.sh"
            }
        ]
    }
    
    # Add matchers for PreToolUse and PostToolUse
    if trigger in ["PreToolUse", "PostToolUse"] and "matchers" in rule:
        hook_config["matchers"] = rule["matchers"]
    
    # Add to settings
    settings["hooks"][trigger].append(hook_config)
    
    # Write back
    with open(settings_file, 'w') as f:
        json.dump(settings, f, indent=2)
    
    print(f"Added hook '{hook_name}' to .claude/settings.local.json")
    print(f"Trigger: {trigger}")
    if "matchers" in hook_config:
        print(f"Matchers: {hook_config['matchers']}")

if __name__ == "__main__":
    exit(main())
"""