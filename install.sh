#!/bin/bash

echo "📦 Instalando dotfiles..."

mkdir -p ~/.config

create_link() {
  local source="$1"
  local target="$2"
  local name="$3"

  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "⚠️  $target ya existe, creando backup..."
    mv "$target" "$target.backup.$(date +%Y%m%d_%H%M%S)"
  fi

  ln -sf "$source" "$target"
  echo "✅ $name configurado"
}

create_link ~/.dotfiles/nvim ~/.config/nvim "Neovim"

echo ""
echo "✨ ¡Dotfiles instalados correctamente!"
