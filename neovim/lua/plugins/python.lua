-- ~/.config/nvim/lua/plugins/python.lua
--
-- uv integration: auto-activate the project virtual environment so pyright
-- and ruff pick up installed packages without any manual `:PythonSelectEnv`.
--
return {
  {
    -- venv-selector: finds and activates uv/virtualenv/pyenv venvs
    "linux-cultist/venv-selector.nvim",
    branch       = "regexp",   -- v2 branch with regexp-based discovery
    ft           = "python",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>pv", "<cmd>VenvSelect<cr>",        desc = "Select venv" },
      { "<leader>pc", "<cmd>VenvSelectCurrent<cr>", desc = "Current venv" },
    },
    opts = {
      -- Prefer uv-created .venv in project root
      search_venv_managers = false,
      search = true,
      name   = { ".venv" },
      -- Auto-select .venv on BufEnter for Python files
      auto_refresh = true,
    },
  },

  {
    -- nvim-dap + nvim-dap-python for debugpy (installed by mason)
    "mfussenegger/nvim-dap",
    ft           = { "python", "typescript", "javascript" },
    dependencies = {
      "mfussenegger/nvim-dap-python",
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end,         desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end,          desc = "Step out" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "DAP UI" },
    },
    config = function()
      local dap    = require("dap")
      local dapui  = require("dapui")
      local dap_py = require("dap-python")

      -- Use debugpy from mason
      local mason_bin = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      dap_py.setup(mason_bin)

      -- Open/close UI automatically
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

      require("nvim-dap-virtual-text").setup()
      dapui.setup()
    end,
  },
}
