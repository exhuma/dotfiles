-- ~/.config/nvim/lua/plugins/folding.lua
return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.opt.foldcolumn   = "1"
      vim.opt.foldlevel    = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable   = true
    end,
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
    config = function(_, opts)
      require("ufo").setup(opts)
      local map = vim.keymap.set
      map("n", "zR", require("ufo").openAllFolds,  { desc = "Open all folds" })
      map("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      map("n", "zK", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = "Peek fold / hover" })
    end,
  },
}
