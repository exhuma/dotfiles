-- ~/.config/nvim/lua/plugins/completion.lua
return {
  -- ─── blink.cmp: fast completion engine ───────────────────────────────────
  {
    "saghen/blink.cmp",
    event   = "InsertEnter",
    version = "*",   -- use latest release with pre-built Rust binary
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        preset = "default",
        -- Tab/S-Tab to select; Enter to confirm
        ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"]    = { "accept", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]   = { "hide" },
        ["<C-b>"]   = { "scroll_documentation_up" },
        ["<C-f>"]   = { "scroll_documentation_down" },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      sources = {
        default    = { "lsp", "path", "snippets", "buffer" },
        -- Supermaven ghost-text runs separately; no blink source needed
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show        = true,
          auto_show_delay_ms = 200,
          window = { border = "rounded" },
        },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
      },
      signature = { enabled = true, window = { border = "rounded" } },
    },
  },

  -- ─── Supermaven: AI ghost-text (inline completion) ───────────────────────
  -- Free tier available; sign up at supermaven.com
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      keymaps = {
        accept_suggestion      = "<C-y>",    -- accept full ghost text
        clear_suggestion       = "<C-]>",
        accept_word            = "<C-j>",    -- accept one word
      },
      ignore_filetypes = { "TelescopePrompt", "oil" },
      color = {
        suggestion_color = "#7a7a7a",
        cterm = 244,
      },
      log_level = "off",
      disable_inline_completion = false,
    },
  },
}
