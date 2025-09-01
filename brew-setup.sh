#!/bin/bash

# Homebrew Installation and Setup Script
# This script installs Homebrew and all development tools

set -e

echo "🍺 Starting Homebrew setup..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📥 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo "🔧 Configuring PATH for Apple Silicon..."
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

# Update Homebrew
echo "🔄 Updating Homebrew..."
brew update

# Install tools from Brewfile
if [ -f "Brewfile" ]; then
    echo "📦 Installing packages from Brewfile..."
    brew bundle install --file=Brewfile
else
    echo "⚠️  Brewfile not found. Please check if the file exists."
fi

# Cleanup
echo "🧹 Cleaning up..."
brew cleanup

echo ""
echo "✅ Homebrew setup completed!"
echo ""
echo "🚀 Installed applications:"
echo "   - Warp Terminal (modern terminal)"
echo "   - Cursor (AI-powered editor)"
echo "   - Visual Studio Code"
echo "   - Docker Desktop"
echo "   - Postman (API testing)"
echo ""
echo "🔧 Development tools:"
echo "   - Languages: Go, Rust, Node.js (nvm), Python (pyenv), Ruby (rbenv)"
echo "   - Cloud: kubectl, helm, terraform, awscli"
echo "   - Utils: fzf, ripgrep, fd, bat, starship, antigen"
echo ""
echo "📝 Next steps:"
echo "   1. Restart your terminal or run: source ~/.zprofile"
echo "   2. Run the dotfiles installer: ./install.sh"
echo "   3. Configure your development environment"
echo ""
echo "🎉 Happy coding!"
