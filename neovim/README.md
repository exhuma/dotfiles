# Neovim Config

Modern Neovim setup for Python (uv) and TypeScript (npm) development with AI completion.

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point, lazy.nvim bootstrap
└── lua/
    ├── config/
    │   ├── options.lua       # Core vim options
    │   └── keymaps.lua       # Global keybindings
    └── plugins/
        ├── colorscheme.lua   # Catppuccin
        ├── completion.lua    # blink.cmp + Supermaven AI
        ├── format-lint.lua   # conform.nvim + nvim-lint
        ├── lsp.lua           # mason + lspconfig (pyright, ruff, ts_ls, eslint)
        ├── python.lua        # venv-selector (uv), debugpy/nvim-dap
        ├── telescope.lua     # Fuzzy finder
        ├── treesitter.lua    # Syntax + text objects
        └── ui.lua            # lualine, gitsigns, which-key, mini.nvim, oil
```

## Quick install

```bash
git clone <this-repo> ~/.config/nvim
cd ~/.config/nvim
./install.sh
```

## Key bindings (leader = Space)

| Key            | Action                        |
|----------------|-------------------------------|
| `<leader>ff`   | Find files                    |
| `<leader>fg`   | Live grep                     |
| `<leader>fb`   | Buffers                       |
| `gd`           | Go to definition              |
| `gr`           | References                    |
| `K`            | Hover documentation           |
| `<leader>ca`   | Code action                   |
| `<leader>rn`   | Rename symbol                 |
| `<leader>lf`   | Format file/selection         |
| `<leader>xx`   | Diagnostics panel (Trouble)   |
| `<leader>pv`   | Select Python venv            |
| `<leader>db`   | Toggle breakpoint             |
| `<leader>dc`   | Continue (DAP)                |
| `-`            | Open file explorer (oil)      |
| `<C-y>`        | Accept AI suggestion          |
| `<C-j>`        | Accept AI word                |
| `<C-]>`        | Clear AI suggestion           |

## Python workflow (uv)

```bash
# Create project with uv
uv init myproject && cd myproject
uv add fastapi

# The .venv is auto-detected by pyright and venv-selector
# To manually switch: <leader>pv
```

## TypeScript workflow

```bash
npm init
npm install typescript
# tsserver is picked up automatically
```

## AI completion

Uses **Supermaven** for ghost-text completions (free tier available).
On first launch: `:SupermavenUseFree` to activate the free tier.

To switch to **GitHub Copilot** instead:
1. Remove `supermaven-nvim` from `plugins/completion.lua`
2. Add `{ "zbirenbaum/copilot.lua", ... }`
