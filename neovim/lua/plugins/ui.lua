-- ~/.config/nvim/lua/plugins/ui.lua
return {
  -- ─── lualine: statusline ─────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme            = "catppuccin",
        globalstatus     = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics" },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = " ●", readonly = "", unnamed = "" } },
        },
        lualine_x = {
          {
            -- Show Supermaven status
            function()
              local ok, sm = pcall(require, "supermaven-nvim.api")
              if ok and sm.is_running() then return "󱙺 SM" end
              return ""
            end,
            color = { fg = "#6c7086" },
          },
          "encoding",
          { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- ─── gitsigns ────────────────────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set
        map("n", "]h", gs.next_hunk,            { buffer = buffer, desc = "Next hunk" })
        map("n", "[h", gs.prev_hunk,            { buffer = buffer, desc = "Prev hunk" })
        map("n", "<leader>hs", gs.stage_hunk,   { buffer = buffer, desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk,   { buffer = buffer, desc = "Reset hunk" })
        map("n", "<leader>hb", gs.blame_line,   { buffer = buffer, desc = "Blame line" })
        map("n", "<leader>hd", gs.diffthis,     { buffer = buffer, desc = "Diff this" })
        map("n", "<leader>hp", gs.preview_hunk, { buffer = buffer, desc = "Preview hunk" })
      end,
    },
  },

  -- ─── which-key ───────────────────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { marks = true, registers = true },
      spec = {
        { "<leader>f", group = "find" },
        { "<leader>l", group = "lsp" },
        { "<leader>h", group = "git hunks" },
        { "<leader>b", group = "buffers" },
      },
    },
  },

  -- ─── mini.nvim (several modules) ─────────────────────────────────────────
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- ai: better text objects (a[, a{, a", function, …)
      require("mini.ai").setup({ n_lines = 500 })
      -- surround: sa, sd, sr
      require("mini.surround").setup()
      -- pairs: auto-close brackets
      -- XXX require("mini.pairs").setup()
      -- bufremove: keeps splits alive when deleting buffers
      require("mini.bufremove").setup()
      -- indentscope: animated indent guide
      -- XXX require("mini.indentscope").setup({
      -- XXX   symbol = "│",
      -- XXX   options = { try_as_border = true },
      -- XXX })
      -- icons (used by telescope, lualine, etc.)
      require("mini.icons").setup()
    end,
  },

  -- ─── Trouble: diagnostics panel ──────────────────────────────────────────
  {
    "folke/trouble.nvim",
    cmd  = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix" },
    },
    opts = { use_diagnostic_signs = true },
  },

  -- ─── indent-blankline: indent guides ─────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main  = "ibl",
    opts  = {
      indent   = { char = "│", tab_char = "│" },
      scope    = { enabled = false },  -- mini.indentscope handles active scope
      exclude  = { filetypes = { "help", "dashboard", "lazy", "mason" } },
    },
  },

  -- ─── oil.nvim: file explorer ─────────────────────────────────────────────
  {
    "stevearc/oil.nvim",
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent dir" } },
    opts = {
      default_file_explorer = true,
      view_options          = { show_hidden = true },
    },
  },
}
