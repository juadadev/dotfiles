#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "📦 Installing dotfiles with GNU Stow..."

# 1. Ensure base directories exist
mkdir -p ~/.config

# 2. Install system dependencies if they are missing
echo "🔍 Checking system dependencies..."

# Binary names to check in the system
commands=(lazygit stow nvim node npm tmux)
# Corresponding pacman package names in Arch/CachyOS
packages=(lazygit stow neovim nodejs npm tmux)

for i in "${!commands[@]}"; do
  cmd="${commands[$i]}"
  pkg="${packages[$i]}"

  if ! command -v "$cmd" &>/dev/null; then
    echo "📥 Installing $pkg via pacman..."
    sudo pacman -S "$pkg" --noconfirm
  else
    echo "✅ $cmd is already installed"
  fi
done

# 3. Apply configurations using Stow
echo "🔗 Creating symlinks with Stow..."
cd ~/dotfiles

# Stow safely manages the Neovim and TMUX symlink handling
stow nvim
stow tmux

echo "✅ Neovim (LazyVim) and tmux configured with Stow"

# =========================================================
# 🚀 TypeScript Runtime & Tools
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

# =========================================================
# 🖥️ Tmux Plugin Manager (TPM) & Plugin Automation
# =========================================================
echo ""
echo "🔌 Configuring Tmux Plugin Manager..."

# 6. Clone TPM if it doesn't exist
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "📥 Cloning Tmux Plugin Manager (tpm)..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "✅ TPM is already installed"
fi

# 7. Auto-install tmux plugins natively without opening tmux manually
echo "📥 Installing tmux plugins..."
# Creates a temporary tmux server in the background to force tpm to install plugins
tmux start-server
tmux new-session -d
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-server
echo "✅ Tmux plugins installed successfully"

echo ""
echo "✨ Dotfiles and development tools installed successfully!"
