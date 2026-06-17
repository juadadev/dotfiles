#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "📦 Installing dotfiles with GNU Stow..."

# 1. Ensure base directories exist
mkdir -p ~/.config

# 2. Install system dependencies if they are missing
for pkg in lazygit stow neovim; do
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
# 🚀 TypeScript Environment (Required for vtsls)
# =========================================================
echo ""
echo "⚡ Configuring JavaScript/TypeScript runtime..."

# 4. Install Bun if missing
if ! command -v bun &>/dev/null; then
  echo "📥 Installing Bun..."
  curl -fsSL https://bun.sh/install | bash

  # Source Bun immediately so it's available in the current script session
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
else
  echo "✅ Bun is already installed"
fi

# 5. Install global npm packages required by Neovim/LazyExtras
if command -v bun &>/dev/null; then
  echo "📦 Installing global development packages via Bun..."
  # Explicitly using the full path to ensure it runs correctly during installation
  ~/.bun/bin/bun add --global @vtsls/language-server
  echo "✅ @vtsls/language-server installed globally"
else
  echo "⚠️ Warning: Bun installation could not be verified. Skipping vtsls."
fi

echo ""
echo "✨ Dotfiles and development tools installed successfully!"
