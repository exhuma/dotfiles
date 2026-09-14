-- ~/.config/nvim/lua/plugins/git.lua
-- Modern fugitive/gitv equivalent: neogit (status/staging UI) + diffview
-- (diff & merge-conflict UI). gitsigns (ui.lua) still handles hunk-level
-- gutter signs/stage/reset/blame.
return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",        desc = "Diffview open" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>",       desc = "Diffview close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
    },
    opts = {},
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit status" },
    },
    opts = {
      integrations = { telescope = true, diffview = true },
    },
  },
}
