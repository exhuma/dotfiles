-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd          = "Telescope",
    version      = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix   = " ",
          selection_caret = " ",
          border          = true,
          borderchars     = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          path_display    = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
          },
          mappings = {
            i = {
              ["<C-k>"]    = actions.move_selection_previous,
              ["<C-j>"]    = actions.move_selection_next,
              ["<C-q>"]    = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"]    = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = vim.fn.executable("rg") == 1
              and { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
              or nil,
          },
        },
        extensions = {
          fzf = {
            fuzzy                  = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode              = "smart_case",
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
