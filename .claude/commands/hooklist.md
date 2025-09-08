---
description: Show installed hooks from all levels - available, global, project, and local
argument-hint: 
allowed-tools: Bash
---
"""
List currently globally installed hooks

RUN THIS PYTHON SCRIPT!!!!!!!! AND THEN SHOW ME THE EXACT OUTPUT

#!/usr/bin/env python3
"""Show hooks from all levels - global, project, local, and available"""

import json
from pathlib import Path

def load_json_safe(file_path):
    """Load JSON file safely, return empty dict if not found or invalid"""
    try:
        if file_path.exists():
            with open(file_path) as f:
                return json.load(f)
    except (json.JSONDecodeError, FileNotFoundError):
        pass
    return {}

def show_configured_hooks(settings_file, title, icon):
    """Show hooks configured in a settings file"""
    print(f"{icon} {title}")
    print("=" * len(f"{icon} {title}"))
    
    if not settings_file.exists():
        print(f"No settings file found")
        print()
        return
    
    settings = load_json_safe(settings_file)
    hooks = settings.get("hooks", {})
    
    if not hooks:
        print("No hooks configured")
        print()
        return
    
    for trigger, hook_configs in hooks.items():
        print(f"\n{trigger}:")
        for config in hook_configs:
            if "matchers" in config:
                print(f"  Matchers: {config['matchers']}")
            for hook in config.get("hooks", []):
                command = hook.get("command", "Unknown")
                hook_name = Path(command).stem if command.endswith('.sh') else command
                print(f"  ✓ {hook_name}")
    print()

def show_available_hooks():
    """Show all available hooks in ~/.claude/hooks/"""
    hooks_dir = Path.home() / ".claude" / "hooks"
    rules_file = Path.home() / ".claude" / "hook-rules.json"
    
    print("🔧 AVAILABLE HOOKS")
    print("==================")
    
    if not hooks_dir.exists():
        print("No hooks directory found")
        print()
        return
    
    hook_rules = load_json_safe(rules_file)
    hook_files = list(hooks_dir.glob("*.sh"))
    
    if not hook_files:
        print("No hooks found")
        print()
        return
    
    for hook_file in sorted(hook_files):
        hook_name = hook_file.stem
        rule = hook_rules.get(hook_name, {})
        trigger = rule.get("trigger", "Unknown")
        desc = rule.get("description", "No description")
        print(f"  {hook_name} ({trigger})")
        print(f"    {desc}")
    print()

def main():
    print("Claude Code Hooks Overview")
    print("==========================")
    print()
    
    # Show global hooks
    global_settings = Path.home() / ".claude" / "settings.json"
    show_configured_hooks(global_settings, "GLOBAL HOOKS (~/.claude/settings.json)", "🌍")
    
    # Show project hooks
    project_settings = Path(".claude/settings.json")
    show_configured_hooks(project_settings, "PROJECT HOOKS (.claude/settings.json)", "📁")
    
    # Show local hooks
    local_settings = Path(".claude/settings.local.json")
    show_configured_hooks(local_settings, "LOCAL HOOKS (.claude/settings.local.json)", "🏠")
    
    # Show available hooks
    show_available_hooks()

if __name__ == "__main__":
    exit(main())
"""
Then show project hooks from .claude/settings.json if it exists.
Then show local hooks from .claude/settings.local.json if it exists.
Then show all available hooks from ~/.claude/hooks/ directory with descriptions from ~/.claude/hook-rules.json.