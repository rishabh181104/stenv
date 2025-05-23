#!/bin/bash
set -e

echo "Starting Neovim dependency installation for openSUSE Tumbleweed..."

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Update system packages
echo "Updating system packages..."
sudo pacman -Syy

# Install basic tools
echo "Installing basic tools (git, curl, neovim, unzip, make)..."
sudo pacman -S git curl neovim unzip make lua-language-server stylua

# Install Vim-Plug
echo "Installing Vim-Plug..."
VIM_PLUG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload"
mkdir -p "$VIM_PLUG_DIR"
curl -fLo "$VIM_PLUG_DIR/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install fzf (for fzf-lua)
echo "Installing fzf..."
sudo pacman -S fzf

# Install Node.js and npm (for LSP servers like tsserver, cssls)
echo "Installing Node.js and npm..."
sudo pacman -S nodejs npm

# Install LSP servers
echo "Installing LSP servers..."
if command_exists npm; then
  sudo npm install -g typescript-language-server vscode-langservers-extracted # JS/TS, HTML, CSS
  sudo npm install -g pyright # Python
  sudo npm install -g sql-language-server # SQL
  sudo npm install -g prettier
else
  echo "Error: npm not found. Skipping LSP server installation."
  exit 1
fi

# Install Rust and rust-analyzer
echo "Installing Rust and rust-analyzer..."
if ! command_exists rustup; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Installing rust, rust-analyzer, rustfmt
echo "Installing rust, rust-analyzer and rustfmt"
rustup component add rustc
rustup component add rust-analyzer
rustup component add rustfmt
cargo install exo

# Install clangd (for C++)
echo "Installing clangd..."
sudo pacman -S clang astyle

# Install Java (for jdtls)
echo "Installing Java..."
sudo pacman -S java-17-openjdk java-17-openjdk-devel

# Install Python and pip (for debugpy, Jupyter, IPython)
echo "Installing Python and pip..."
sudo pacman -S python313 python313-pip python313-debugpy python313-ipython python313-black
# pip3 install --user debugpy jupytext ipython

# Install PostgreSQL client (for vim-dadbod)
echo "Installing PostgreSQL client..."
sudo pacman -S postgresql postgresql-devel

# Install gdb (for C++ debugging)
echo "Installing gdb..."
sudo pacman -S gdb

# Clone plugins (handled by Vim-Plug, but ensure directory exists)
echo "Setting up plugin directory..."
mkdir -p ~/.local/share/nvim/plugged

# Instructions for user
echo "Installation complete!"
echo "Next steps:"
echo "1. Copy your Neovim configuration files to ~/.config/nvim/"
echo "2. Open Neovim and run ':PlugInstall' to install plugins."
echo "3. Configure PostgreSQL connections in ~/.config/nvim/db_ui/connections.json if needed."
echo "4. Verify LSP servers with ':LspInstallInfo' and debugging with ':checkhealth'."
