-- ~/.config/nvim/lua/plugins/emmet.lua
return {
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" },
    init = function()
      -- Legacy leader was <C-y>, but Supermaven now owns that key
      -- ("accept full suggestion"), so this uses a free one instead.
      vim.g.user_emmet_leader_key = "<C-z>"
      vim.g.user_emmet_settings = {
        javascript = { extends = "jsx" },
        typescript = { extends = "tsx" },
      }
    end,
  },
}
