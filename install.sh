#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "📦 Installing dotfiles with GNU Stow..."

# 1. Ensure base directories exist
mkdir -p ~/.config

# 2. Install system dependencies if they are missing
for pkg in lazygit stow neovim nodejs; do
  if ! command -v "$pkg" &>/dev/null; then
    echo "📥 Installing $pkg via pacman..."
    sudo pacman -S "$pkg" --noconfirm
  else
    echo "✅ $pkg is already installed"
  fi
done

# 3. Apply configurations using Stow
echo "🔗 Creating symlinks with Stow..."
cd ~/dotfiles

# Stow safely manages the Neovim symlink handling
stow nvim

echo "✅ Neovim (LazyVim) configured with Stow"

# =========================================================
# 🚀 JavaScript/TypeScript Runtime & Tools
# =========================================================
echo ""
echo "⚡ Configuring JavaScript/TypeScript environments..."

# 4. Install global npm packages required by Neovim/LazyExtras
if command -v npm &>/dev/null; then
  echo "📦 Installing global development packages via npm..."
  sudo npm install -g @vtsls/language-server
  echo "✅ @vtsls/language-server installed globally via npm"
else
  echo "⚠️ Error: npm not found. Skipping vtsls installation."
  exit 1
fi

# 5. Install Bun (Standalone installation only)
if ! command -v bun &>/dev/null; then
  echo "📥 Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  echo "✅ Bun installed successfully (standalone)"
else
  echo "✅ Bun is already installed"
fi

echo ""
echo "✨ Dotfiles and development tools installed successfully!"
