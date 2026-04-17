#!/usr/bin/env bash
# install.sh — Sets up the Neovim config and required system tools (Linux, user-space)
set -euo pipefail

CONFIG_DIR="$HOME/.config/nvim"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Neovim config..."

# ── Backup existing config ────────────────────────────────────────────────────
if [[ -d "$CONFIG_DIR" && "$CONFIG_DIR" != "$SCRIPT_DIR" ]]; then
  BACKUP="$HOME/.config/nvim.bak.$(date +%s)"
  echo "    Backing up existing config to $BACKUP"
  mv "$CONFIG_DIR" "$BACKUP"
fi

# ── Symlink or copy config ────────────────────────────────────────────────────
if [[ "$SCRIPT_DIR" != "$CONFIG_DIR" ]]; then
  ln -sfn "$SCRIPT_DIR" "$CONFIG_DIR"
  echo "    Linked $SCRIPT_DIR → $CONFIG_DIR"
else
  echo "    Config already in place at $CONFIG_DIR"
fi

# ── Check Neovim version ──────────────────────────────────────────────────────
if ! command -v nvim &>/dev/null; then
  echo ""
  echo "  [!] Neovim not found. Install via:"
  echo "      https://github.com/neovim/neovim/releases/latest"
  echo "      (AppImage or tarball to ~/bin for user-space install)"
  exit 1
fi

NVIM_VERSION=$(nvim --version | head -1 | grep -oP '\d+\.\d+\.\d+')
echo "    Found Neovim $NVIM_VERSION (0.10+ required)"

# ── External tools ────────────────────────────────────────────────────────────
echo ""
echo "==> Checking external tools..."

check_or_warn() {
  if command -v "$1" &>/dev/null; then
    echo "    ✓ $1"
  else
    echo "    ✗ $1 — $2"
  fi
}

check_or_warn "git"        "required (install via package manager)"
check_or_warn "make"       "required for telescope-fzf-native (install via package manager)"
check_or_warn "rg"         "ripgrep — strongly recommended for Telescope (cargo install ripgrep  OR  apt install ripgrep)"
check_or_warn "fd"         "fd-find — recommended (cargo install fd-find  OR  apt install fd-find)"
check_or_warn "node"       "required for typescript-language-server (install via nvm or fnm)"
check_or_warn "npm"        "required for TS tooling"
check_or_warn "uv"         "required for Python tooling (install: curl -LsSf https://astral.sh/uv/install.sh | sh)"

# ── npm global tools (TS) ─────────────────────────────────────────────────────
if command -v npm &>/dev/null; then
  echo ""
  echo "==> Installing npm global tools (user-space)..."
  npm config set prefix "$HOME/.local"
  for pkg in typescript-language-server typescript prettier eslint_d; do
    if ! npm list -g "$pkg" &>/dev/null 2>&1; then
      echo "    Installing $pkg..."
      npm install -g "$pkg"
    else
      echo "    ✓ $pkg already installed"
    fi
  done
  echo "    Make sure $HOME/.local/bin is in your PATH"
fi

# ── uv Python tools ───────────────────────────────────────────────────────────
if command -v uv &>/dev/null; then
  echo ""
  echo "==> Installing Python tools via uv..."
  for tool in ruff pyright; do
    if uv tool list 2>/dev/null | grep -q "^$tool"; then
      echo "    ✓ $tool already installed"
    else
      echo "    Installing $tool..."
      uv tool install "$tool"
    fi
  done
  echo "    Make sure \$(uv tool dir)/bin is in your PATH"
  echo "    Tip: add  export PATH=\"\$HOME/.local/bin:\$(uv tool dir)/bin:\$PATH\"  to your shell rc"
fi

# ── Neovim first-run ──────────────────────────────────────────────────────────
echo ""
echo "==> First-run note:"
echo "    Open Neovim and wait for lazy.nvim to install plugins."
echo "    Then run :Mason to verify LSP/DAP tools."
echo "    Supermaven: run :SupermavenUseFree after install."
echo ""
echo "Done! Open Neovim to finish the setup."
