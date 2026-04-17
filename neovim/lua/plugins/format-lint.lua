-- ~/.config/nvim/lua/plugins/format-lint.lua
return {
  -- ─── conform.nvim: formatting ────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    -- event = { "BufWritePre" },
    -- cmd   = { "ConformInfo" },
    opts = {
      -- formatters_by_ft = {
      --   python     = { "ruff_format", "ruff_organize_imports" },
      --   typescript = { "prettier" },
      --   javascript = { "prettier" },
      --   typescriptreact = { "prettier" },
      --   javascriptreact = { "prettier" },
      --   json       = { "prettier" },
      --   yaml       = { "prettier" },
      --   markdown   = { "prettier" },
      --   html       = { "prettier" },
      --   css        = { "prettier" },
      --   lua        = { "stylua" },
      --   -- Fallback: try LSP format for anything else
      --   ["_"]      = { "trim_whitespace" },
      -- },
      -- format_on_save = {
      --   timeout_ms   = 1500,
      --   lsp_fallback = true,
      -- },
      -- formatters = {
      --   ruff_format = {
      --     -- Use project-local ruff via uv tool run if available
      --     command = function()
      --       local uv_ruff = vim.fn.findfile("pyproject.toml", ".;")
      --       if uv_ruff ~= "" then
      --         return "ruff"
      --       end
      --       return "ruff"
      --     end,
      --   },
      --   prettier = {
      --     -- Use project-local prettier when available
      --     require_cwd = false,
      --     cwd = require("conform.util").root_file({
      --       ".prettierrc",
      --       ".prettierrc.js",
      --       ".prettierrc.json",
      --       "prettier.config.js",
      --       "package.json",
      --     }),
      --   },
      -- },
    },
  },

  -- ─── nvim-lint: async linting ────────────────────────────────────────────
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python     = { "ruff" },
        typescript = { "eslint_d" },
        javascript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascriptreact = { "eslint_d" },
      }

      -- Point eslint_d to the project's eslint config
      lint.linters.eslint_d = vim.tbl_deep_extend("force", lint.linters.eslint_d or {}, {
        args = {
          "--no-eslintrc",
          "--config", function()
            local cfg = vim.fn.findfile(".eslintrc.js", ".;")
                      or vim.fn.findfile(".eslintrc.cjs", ".;")
                      or vim.fn.findfile("eslint.config.js", ".;")
                      or vim.fn.findfile("eslint.config.mjs", ".;")
            return cfg ~= "" and cfg or nil
          end,
        },
      })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        callback = function()
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
