#!/usr/bin/env bash
set -euo pipefail

echo "🤖 Setting up Dean's Claude Code customizations (Linux/Debian)..."

# Check if we're on Debian/Ubuntu
if ! command -v apt >/dev/null 2>&1; then
    echo "❌ This setup script is designed for Debian/Ubuntu systems"
    echo "   Please use the macOS setup.sh if you're on macOS"
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."

# Update package list
echo "  Updating package list..."
sudo apt update

# Install jq (required for JSON parsing in hooks)
if ! command -v jq >/dev/null 2>&1; then
    echo "  Installing jq..."
    sudo apt install -y jq
fi

# Check Python 3
if ! command -v python3 >/dev/null 2>&1; then
    echo "  Installing Python 3..."
    sudo apt install -y python3 python3-pip
fi

# Install pip if not available
if ! command -v pip3 >/dev/null 2>&1; then
    echo "  Installing pip3..."
    sudo apt install -y python3-pip
fi

# Install curl (often needed)
if ! command -v curl >/dev/null 2>&1; then
    echo "  Installing curl..."
    sudo apt install -y curl
fi

# Install Node.js and npm (for MCP servers)
if ! command -v node >/dev/null 2>&1; then
    echo "  Installing Node.js and npm..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Install optional but commonly used formatters
echo "🔧 Installing optional code formatters..."

# Ruby formatters
if command -v gem >/dev/null 2>&1; then
    echo "  Installing rubocop..."
    gem install rubocop || echo "  ⚠️  Could not install rubocop (you may need to install Ruby first)"
elif command -v apt >/dev/null 2>&1; then
    echo "  Installing Ruby and rubocop..."
    sudo apt install -y ruby-full
    gem install rubocop || echo "  ⚠️  Could not install rubocop"
fi

# Python formatters
if command -v pip3 >/dev/null 2>&1; then
    echo "  Installing Python dependencies..."
    pip3 install -r requirements.txt || echo "  ⚠️  Could not install Python requirements"
    echo "  Installing ruff..."
    pip3 install ruff || echo "  ⚠️  Could not install ruff"
fi

# JavaScript formatters
if command -v npm >/dev/null 2>&1; then
    echo "  Installing prettier globally..."
    sudo npm install -g prettier || echo "  ⚠️  Could not install prettier"
fi

# Rust formatter (install rust first if needed)
if ! command -v rustup >/dev/null 2>&1; then
    echo "  Installing Rust toolchain..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo "  ✅ rustfmt available with Rust toolchain"
else
    echo "  ✅ rustfmt available with Rust toolchain"
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
cp CLAUDE.md "$HOME/.claude/" 2>/dev/null || true
cp requirements.txt "$HOME/.claude/" 2>/dev/null || true
cp .claude/hook-rules.json "$HOME/.claude/"
[[ -f .claude/settings.json ]] && cp .claude/settings.json "$HOME/.claude/" || true

# Make all Python scripts executable
chmod +x "$HOME/.claude/hooks"/*.sh

# Setup MCP servers
echo "🔌 Setting up MCP servers..."

# Add MCP setup function to shell profile
echo "🐚 Adding MCP setup function to shell profile..."

# Detect shell and set appropriate profile file
if [[ "$SHELL" =~ zsh ]]; then
    PROFILE_FILE="$HOME/.zshrc"
elif [[ "$SHELL" =~ bash ]]; then
    PROFILE_FILE="$HOME/.bashrc"
else
    echo "  ⚠️  Unknown shell, defaulting to ~/.zshrc"
    PROFILE_FILE="$HOME/.zshrc"
fi

# Add the function to the profile if it doesn't exist
if ! grep -q "setup-mcp()" "$PROFILE_FILE" 2>/dev/null; then
    echo "  Adding setup-mcp function to $PROFILE_FILE..."
    cat >> "$PROFILE_FILE" << 'EOF'

# Claude Code MCP setup function
setup-mcp() {
    echo "🔌 Adding common MCP servers to current project..."
    claude mcp add --transport http notion https://mcp.notion.com/mcp
    claude mcp add --transport http github https://mcp.github.com/mcp
    claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
    claude mcp add --transport sse atlassian https://mcp.atlassian.com/v1/sse
    echo "✅ Added common MCP servers. Run 'claude /mcp' to see available servers"
}
EOF
    echo "  ✅ Added setup-mcp function"
else
    echo "  ✅ setup-mcp function already exists"
fi

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
echo "  /hooklist - Show all hooks from all levels"
echo "  /localhookadd <hook-name> - Add hook to local project"
echo "  /localhookrm <hook-name> - Remove hook from local project"
echo "  /projecthookadd <hook-name> - Add hook to project"
echo "  /projecthookrm <hook-name> - Remove hook from project"
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