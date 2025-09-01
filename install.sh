#!/bin/bash

# Dotfiles Installation Script
# This script sets up development environment configurations

set -e

DOTFILES_DIR="$HOME/Projects/dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "🚀 Starting dotfiles installation..."

# Create backup directory
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "📦 Created backup directory: $BACKUP_DIR"
fi

# Function to backup and link files
backup_and_link() {
    local source_file="$1"
    local target_file="$2"
    
    if [ -e "$target_file" ]; then
        echo "📋 Backing up existing $target_file"
        mv "$target_file" "$BACKUP_DIR/"
    fi
    
    echo "🔗 Linking $source_file -> $target_file"
    ln -sf "$source_file" "$target_file"
}

# Install Vim Plug manager
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "📥 Installing Vim Plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Link Vim configuration
backup_and_link "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# Link Zsh configuration
backup_and_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Link Git configuration
backup_and_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# Create directories for editor configurations
mkdir -p "$HOME/Library/Application Support/Cursor/User"
mkdir -p "$HOME/Library/Application Support/Code/User"

# Link Cursor configurations
backup_and_link "$DOTFILES_DIR/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
backup_and_link "$DOTFILES_DIR/cursor/keybindings.json" "$HOME/Library/Application Support/Cursor/User/keybindings.json"

# Link VSCode configurations
backup_and_link "$DOTFILES_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

echo ""
echo "✅ Dotfiles installation completed!"
echo ""
echo "📁 Backup directory: $BACKUP_DIR"
echo ""
echo "🔧 Next steps:"
echo "   1. Install dependencies (if not done): ./brew-setup.sh"
echo "   2. Open Vim and run :PlugInstall to install plugins"
echo "   3. Restart your terminal to apply Zsh changes"
echo "   4. Configure GPG signing (optional):"
echo "      - Generate GPG key: gpg --gen-key"
echo "      - Get key ID: gpg --list-secret-keys --keyid-format LONG"
echo "      - Edit .gitconfig: uncomment signingkey and gpgsign lines"
echo ""
echo "🎉 Happy coding!"
