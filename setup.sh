#!/usr/bin/env bash
set -euo pipefail

echo "🤖 Setting up Dean's Claude Code customizations..."

# Check if we're on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "❌ This setup script is designed for macOS only"
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."

# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not found. Please install Homebrew first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# Install jq (required for JSON parsing in hooks)
if ! command -v jq >/dev/null 2>&1; then
    echo "  Installing jq..."
    brew install jq
fi

# Check Python 3
if ! command -v python3 >/dev/null 2>&1; then
    echo "❌ Python 3 not found. Installing with Homebrew..."
    brew install python3
fi

# Install optional but commonly used formatters
echo "🔧 Installing optional code formatters..."

# Ruby formatters
if command -v gem >/dev/null 2>&1; then
    echo "  Installing rubocop..."
    gem install rubocop || echo "  ⚠️  Could not install rubocop (you may need to install Ruby first)"
fi

# Python dependencies and formatters
if command -v pip3 >/dev/null 2>&1; then
    echo "  Installing Python dependencies..."
    pip3 install -r requirements.txt || echo "  ⚠️  Could not install Python requirements"
    echo "  Installing ruff..."
    pip3 install ruff || echo "  ⚠️  Could not install ruff"
fi

# JavaScript formatters
if command -v npm >/dev/null 2>&1; then
    echo "  Installing prettier globally..."
    npm install -g prettier || echo "  ⚠️  Could not install prettier"
fi

# Rust formatter (comes with Rust toolchain)
if command -v rustup >/dev/null 2>&1; then
    echo "  ✅ rustfmt available with Rust toolchain"
else
    echo "  ℹ️  Install Rust toolchain for rustfmt: https://rustup.rs/"
fi

# Create ~/.claude directory and copy customizations
echo "📁 Setting up Claude customizations..."

# Create ~/.claude if it doesn't exist
mkdir -p "$HOME/.claude"

# Backup existing settings if they exist
if [[ -f "$HOME/.claude/settings.json" ]]; then
    echo "  Backing up existing settings.json..."
    cp "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Copy our customizations
echo "  Copying customizations to ~/.claude..."

# Copy directories
echo "    Copying commands..."
mkdir -p "$HOME/.claude/commands"
cp .claude/commands/* "$HOME/.claude/commands/"

echo "    Copying hooks..."
mkdir -p "$HOME/.claude/hooks"
cp .claude/hooks/* "$HOME/.claude/hooks/"

echo "    Copying agents..."
mkdir -p "$HOME/.claude/agents"
cp .claude/agents/* "$HOME/.claude/agents/" 2>/dev/null || true

# Copy individual files
echo "    Copying configuration files..."
cp .claude/CLAUDE.md "$HOME/.claude/" 2>/dev/null || true
cp .claude/hook-rules.json "$HOME/.claude/" || true
cp .claude/settings.json "$HOME/.claude/" || true
[[ -f .claude/settings.json ]] && cp .claude/settings.json "$HOME/.claude/" || true

# Make all Python scripts executable
chmod +x "$HOME/.claude/commands"/*.py
chmod +x "$HOME/.claude/hooks"/*.sh

echo ""
echo "✅ Setup complete!"
echo ""
echo "Available commands:"
echo "  /brainstorm [topic] [count] - Structured idea generation"
echo "  /memorize [global|project] [text] - Save to Memory Bank"
echo "  /websearch [query] [--site=domain] - Web search with domain filtering"
echo "  /commit [type] [subject] [--now] - Generate conventional commits"
echo ""
echo "Hook management:"
echo "  globalhookshow.py - Show global hooks"
echo "  projecthookshow.py - Show project hooks"
echo "  localhookshow.py - Show local project hooks"
echo "  projecthookadd.py <hook-name> - Add hook to project"
echo "  localhookadd.py <hook-name> - Add hook to local project"
echo "  projecthookrm.py <hook-name> - Remove hook from project"
echo "  localhookrm.py <hook-name> - Remove hook from local project"
echo ""
echo "Available hooks:"
echo "  pre_tool_use_safety - Block dangerous rm -rf commands"
echo "  post_edit_files_ruby_style - Format Ruby files"
echo "  post_edit_files_python_style - Format Python files"
echo "  post_edit_files_js_ts_style - Format JS/TS files"
echo "  post_edit_files_rust_style - Format Rust files"
echo "  pre_compact_memory_save - Save session summary before compact"
echo ""
echo "🎉 Your Claude Code setup is ready!"