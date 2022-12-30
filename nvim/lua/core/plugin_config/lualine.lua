require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'apprentice',
    },
    sections = {
        lualine_a = {
            { 'filename', path=1 }
        }
    }
}
