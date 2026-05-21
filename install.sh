#!/bin/bash

echo "📦 Instalando dotfiles..."

mkdir -p ~/.config

# Instalar lazygit si no existe
if ! command -v lazygit &>/dev/null; then
  echo "📥 Instalando lazygit con pacman..."
  sudo pacman -S lazygit --noconfirm
else
  echo "✅ lazygit ya está instalado"
fi

create_link() {
  local source="$1"
  local target="$2"
  local name="$3"

  # Eliminar si existe (ya sea archivo, directorio o enlace)
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "🗑️  Eliminando $target existente..."
    rm -rf "$target"
  fi

  # Crear el enlace simbólico
  ln -sf "$source" "$target"
  echo "✅ $name configurado (enlace creado)"
}

create_link ~/dotfiles/nvim ~/.config/nvim "Neovim"

echo ""
echo "✨ ¡Dotfiles instalados correctamente!"
