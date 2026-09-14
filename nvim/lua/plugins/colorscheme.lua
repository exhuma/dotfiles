-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  {
    "catppuccin/nvim",
    name     = "catppuccin",
    priority = 1000,
    lazy     = false,
    opts = {
      flavour         = "mocha",
      transparent_background = false,
      integrations = {
        blink_cmp    = true,
        gitsigns     = true,
        mason        = true,
        mini         = { enabled = true },
        telescope    = { enabled = true },
        treesitter   = true,
        which_key    = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
