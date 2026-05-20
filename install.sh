# Crear script install.sh
cat > install.sh << 'EOF'
#!/bin/bash

# Crear enlace para Neovim
ln -sf ~/.dotfiles/nvim ~/.config/nvim

echo "¡Dotfiles instalados!"
EOF

chmod +x install.sh
