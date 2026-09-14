# Neovim Config

Modern Neovim setup for Python (uv) and TypeScript (npm) development with AI
completion. Symlinked into place as `~/.config/nvim` by the parent dotfiles
repo's `install` script.

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point, lazy.nvim bootstrap
├── ftdetect/, syntax/        # Personal "clproc" changelog-processor filetype
├── snippets/                 # Custom snippets (blink.cmp format)
├── legacy/                   # Old .vimrc-based config, kept for reference
└── lua/
    ├── config/
    │   ├── options.lua       # Core vim options
    │   └── keymaps.lua       # Global keybindings
    └── plugins/
        ├── colorscheme.lua   # Catppuccin
        ├── completion.lua    # blink.cmp + Supermaven AI
        ├── format-lint.lua   # conform.nvim + nvim-lint
        ├── lsp.lua           # mason + lspconfig (pyright, ruff, ts_ls, eslint, lua_ls)
        ├── python.lua        # venv-selector (uv), debugpy/nvim-dap
        ├── telescope.lua     # Fuzzy finder
        ├── treesitter.lua    # Syntax + text objects
        ├── folding.lua       # nvim-ufo + treesitter folds
        ├── git.lua           # neogit + diffview.nvim
        ├── emmet.lua         # HTML/CSS/JSX expansion
        ├── table-mode.lua    # Markdown table formatting
        └── ui.lua            # lualine, gitsigns, which-key, mini.nvim, oil
```

## Install

Tool checks (ripgrep, fd, node/npm, uv) and language-tool installs
(typescript-language-server, prettier, eslint_d, ruff, pyright) are handled
by `./install-tools.sh`. The `~/.config/nvim` symlink itself is created by
the parent dotfiles repo's own `install` script.

## Key bindings (leader = Space)

| Key            | Action                        |
|----------------|--------------------------------|
| `<leader>ff`   | Find files                    |
| `<leader>fg`   | Live grep                     |
| `<leader>fb`   | Buffers                       |
| `gd`           | Go to definition               |
| `gr`           | References                    |
| `K`            | Hover documentation            |
| `<leader>ca`   | Code action                    |
| `<leader>rn`   | Rename symbol                  |
| `<leader>lf`   | Format file/selection          |
| `<leader>xx`   | Diagnostics panel (Trouble)    |
| `<leader>gg`   | Neogit status                  |
| `<leader>gd`   | Diffview open                  |
| `<leader>pv`   | Select Python venv              |
| `<leader>db`   | Toggle breakpoint               |
| `<leader>dc`   | Continue (DAP)                  |
| `-`            | Open file explorer (oil)        |
| `zR` / `zM`    | Open/close all folds            |
| `zK`           | Peek fold / hover                |
| `<C-l>`        | Accept completion (blink.cmp)    |
| `<C-y>`        | Accept AI suggestion (Supermaven)|
| `<C-j>`        | Accept AI word (Supermaven)      |
| `<C-]>`        | Clear AI suggestion              |

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
