#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "📦 Installing dotfiles with GNU Stow..."

# 1. Ensure base directories exist
mkdir -p ~/.config

# 2. Install system dependencies if they are missing
for pkg in lazygit neovim stow; do
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

echo ""
echo "✨ Dotfiles installed successfully!"
