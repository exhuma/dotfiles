vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    renderer = {
        indent_width = 2,
        indent_markers = {
            enable = true
        }
    },
})

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
