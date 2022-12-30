vim.opt.backspace = 'indent,eol,start'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', 'g*', 'g*zz')
vim.keymap.set('n', 'g#', 'g#zz')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>')

-- Helper to resolve merge-conflicts
vim.keymap.set('n', '<leader>d', 'ddp/=======$<CR>jdd<C-o>P')

-- Quickly insert dates/times
vim.keymap.set('n', '<F4>', 'a<C-R>=strftime("%Y-%m-%d")<CR><ESC>', {remap=true})
vim.keymap.set('i', '<F4>', '<C-R>=strftime("%Y-%m-%d")<CR>', {remap=true})
vim.keymap.set('n', '<F5>', 'a<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>', {remap=true})
vim.keymap.set('i', '<F5>', '<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>', {remap=true})
vim.keymap.set('n', '<F6>', 'a<C-R>=strftime("%Y%m%d")<CR><ESC>', {remap=true})
vim.keymap.set('i', '<F6>', '<C-R>=strftime("%Y%m%d")<CR>', {remap=true})

-- Behave somewhat like 'less' for toggling word-wrap
vim.keymap.set('n', '-S', ':set nowrap!<CR>')

-- Run ALEFix
vim.keymap.set('n', '<C-i>', ':ALEFix<CR>')
