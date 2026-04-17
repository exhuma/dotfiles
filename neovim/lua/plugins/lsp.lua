-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  -- Mason: manages LSP servers, DAP adapters, linters, formatters
  {
    "williamboman/mason.nvim",
    cmd  = "Mason",
    opts = {
      ensure_installed = {
        -- Python
        "pyright",
        "ruff",
        "debugpy",
        -- TypeScript / JS
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
      },
      ui = { border = "rounded" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      -- Auto-install ensure_installed list
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  -- Bridge mason ↔ lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {},
  },

  -- Core LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Better LSP UI (borders, virtual text)
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Shared on_attach
      local on_attach = function(_, bufnr)
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        -- Format on save handled by conform; disable LSP format fallback here
      end

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text  = { prefix = "●", source = "if_many" },
        signs         = true,
        underline     = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true },
      })

      -- ─── Python ──────────────────────────────────────────────────────────
      -- pyright: type checking; ruff handles linting/formatting via separate LSP
      vim.lsp.config("pyright", {
        on_attach    = on_attach,
        capabilities = capabilities,
        settings = {
          pyright = {
            -- Use ruff for import organising to avoid conflicts
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              typeCheckingMode   = "standard",
              autoSearchPaths    = true,
              useLibraryCodeForTypes = true,
              -- Auto-detect uv virtual environments
              -- pyright looks for .venv in project root automatically
            },
          },
        },
      })

      -- ruff as an LSP (replaces ruff-lsp; built-in since ruff 0.3)
      vim.lsp.config("ruff", {
        on_attach    = on_attach,
        capabilities = capabilities,
        init_options = {
          settings = {
            -- ruff.toml or pyproject.toml picked up automatically
            lint = { enable = true },
            format = { enable = true },
          },
        },
      })

      -- ─── TypeScript / JavaScript ─────────────────────────────────────────
      vim.lsp.config("ts_ls", {
        on_attach    = on_attach,
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints            = "all",
              includeInlayFunctionParameterTypeHints    = true,
              includeInlayVariableTypeHints             = true,
              includeInlayPropertyDeclarationTypeHints  = true,
              includeInlayFunctionLikeReturnTypeHints   = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints            = "all",
              includeInlayFunctionParameterTypeHints    = true,
            },
          },
        },
      })

      -- ESLint via LSP (handles eslint daemon automatically)
      vim.lsp.config("eslint", {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Auto-fix on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer  = bufnr,
            command = "EslintFixAll",
          })
        end,
        capabilities = capabilities,
      })
      vim.lsp.enable("ruff")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("eslint")
    end,
  },
}
