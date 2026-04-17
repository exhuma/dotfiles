-- ~/.config/nvim/lua/config/options.lua
local opt = vim.opt

-- UI
opt.number         = true
opt.relativenumber = true
opt.signcolumn     = "yes"
opt.cursorline     = true
opt.termguicolors  = true
opt.showmode       = false          -- mode shown in statusline instead
opt.laststatus     = 3              -- global statusline
opt.cmdheight      = 1
opt.pumheight      = 10
opt.scrolloff      = 8
opt.sidescrolloff  = 8

-- Indentation (overridden per-language by treesitter/LSP)
opt.expandtab   = true
opt.shiftwidth  = 4
opt.tabstop     = 4
opt.softtabstop = 4
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = true
opt.incsearch  = true

-- Files
opt.swapfile  = false
opt.backup    = false
opt.undofile  = true
opt.undodir   = vim.fn.stdpath("data") .. "/undo"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Misc
opt.updatetime  = 200
opt.timeoutlen  = 300
opt.clipboard   = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.wrap        = false
opt.list        = true
opt.listchars   = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand  = "split"     -- live preview of :s
opt.confirm     = true        -- ask instead of error for unsaved changes

-- Python: point to the global uv-managed venv if it exists
-- Per-project venvs are auto-detected via lspconfig
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/uv/python/cpython-3.12-linux-x86_64-gnu/bin/python3")
