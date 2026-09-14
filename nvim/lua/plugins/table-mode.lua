-- ~/.config/nvim/lua/plugins/table-mode.lua
return {
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown", "text" },
    init = function()
      vim.g.table_mode_corner_corner = "+"
      vim.g.table_mode_header_fillchar = "="
    end,
  },
}
