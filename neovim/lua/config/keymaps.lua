-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.keymap.set

-- Leader
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- Easier escape
map("i", "jk", "<Esc>", { desc = "Escape insert mode" })

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize splits
map("n", "<C-Up>",    "<cmd>resize +2<cr>")
map("n", "<C-Down>",  "<cmd>resize -2<cr>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- Better up/down (wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("n", "<A-k>", "<cmd>m .-2<cr>==")
map("v", "<A-j>", ":m '>+1<cr>gv=gv")
map("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- Keep visual selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Save
map({ "n", "i" }, "<C-s>", "<cmd>w<cr><Esc>", { desc = "Save file" })

-- Buffers
map("n", "<S-l>", "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Quickfix
map("n", "]q", "<cmd>cnext<cr>")
map("n", "[q", "<cmd>cprev<cr>")

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",   { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",   { desc = "Help" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",    { desc = "Recent files" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })

-- LSP (defined here as globals; per-buffer attach in lsp.lua)
map("n", "K",          vim.lsp.buf.hover,          { desc = "Hover docs" })
map("n", "gd",         vim.lsp.buf.definition,      { desc = "Go to definition" })
map("n", "gr",         "<cmd>Telescope lsp_references<cr>", { desc = "References" })
map("n", "gi",         vim.lsp.buf.implementation,  { desc = "Implementation" })
map("n", "<leader>ca", vim.lsp.buf.code_action,     { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename,          { desc = "Rename" })
map("n", "<leader>e",  vim.diagnostic.open_float,   { desc = "Show diagnostic" })
map("n", "]d",         vim.diagnostic.goto_next,    { desc = "Next diagnostic" })
map("n", "[d",         vim.diagnostic.goto_prev,    { desc = "Prev diagnostic" })

-- Format
map({ "n", "v" }, "<leader>lf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })

-- Lazy
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- Mason
map("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Mason" })
