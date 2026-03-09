-- Tools plugins: Fuzzy finder, Snippets, AI, Language-specific, etc.
local utils = require("utils")
local plugin_dir = vim.fn.stdpath("data") .. "/lazy"

return {
  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    config = function()
      require("config.fzf-lua")
    end,
    event = "VeryLazy",
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
    },
  },

  -- Snippet engine
  {
    "SirVer/ultisnips",
    dependencies = {
      "honza/vim-snippets",
    },
    event = "InsertEnter",
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = {
      latex = { enabled = false },
    },
    ft = { "markdown" },
  },

  -- Markdown footnotes
  { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } },

  -- Tabular for markdown tables
  { "godlygeek/tabular", ft = { "markdown" } },

  -- Markdown preview with Mermaid support
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install && git restore .",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      -- Enable mermaid rendering
      vim.g.mkdp_preview_options = {
        mermaid = { theme = "default" },
      }
    end,
  },

  -- Grammar check (Mac only)
  {
    "rhysd/vim-grammarous",
    enabled = function()
      return vim.g.is_mac
    end,
    ft = { "markdown" },
  },

  -- LaTeX
  {
    "lervag/vimtex",
    enabled = function()
      return utils.executable("latex")
    end,
    ft = { "tex" },
  },

  -- Tmux config highlighting
  {
    "tmux-plugins/vim-tmux",
    enabled = function()
      return utils.executable("tmux")
    end,
    ft = { "tmux" },
  },

  -- Lisp IDE
  {
    "vlime/vlime",
    enabled = function()
      return utils.executable("sbcl")
    end,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/vim")
    end,
    ft = { "lisp" },
  },

  -- Tags viewer
  {
    "liuchengxu/vista.vim",
    enabled = function()
      return utils.executable("ctags")
    end,
    cmd = "Vista",
  },

  -- URL opener (Mac/Windows only)
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    enabled = function()
      return vim.g.is_win or vim.g.is_mac
    end,
    config = true,
    submodules = false,
  },

  -- Handy unix commands
  { "tpope/vim-eunuch", cmd = { "Rename", "Delete" } },

  -- Vim script debugging
  { "tpope/vim-scriptease", cmd = { "Scriptnames", "Messages", "Verbose" } },

  -- Async command execution
  { "skywind3000/asyncrun.vim", lazy = true, cmd = { "AsyncRun" } },

  -- TOML syntax
  { "cespare/vim-toml", ft = { "toml" }, branch = "main" },

  -- Firenvim (browser editing)
  {
    "glacambre/firenvim",
    enabled = function()
      return vim.g.is_win or vim.g.is_mac
    end,
    build = function()
      local firenvim_path = plugin_dir .. "/firenvim"
      vim.opt.runtimepath:append(firenvim_path)
      vim.cmd("runtime! firenvim.vim")
      local path_env = vim.env.PATH
      local prologue = string.format('export PATH="%s"', path_env)
      local cmd_str = string.format(":call firenvim#install(0, '%s')", prologue)
      vim.cmd(cmd_str)
    end,
  },

  -- DAP Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dd", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
    },
    config = function()
      require("config.dap")
    end,
  },

  -- Code formatting (replaces prettier.nvim with broader formatter support)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    config = function()
      require("config.conform")
    end,
  },

  -- Session management
  { "tpope/vim-obsession", cmd = "Obsession" },

  -- OSC yank for remote clipboard (Linux only)
  {
    "ojroques/vim-oscyank",
    enabled = function()
      return vim.g.is_linux
    end,
    cmd = { "OSCYank", "OSCYankReg" },
  },

  -- AI Chat (CopilotChat with Claude)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain", "CopilotChatReview", "CopilotChatFix" },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = { "n", "v" }, desc = "Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", mode = { "n", "v" }, desc = "Review code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = { "n", "v" }, desc = "Fix code" },
    },
    opts = {
      model = "claude-sonnet-4",
    },
  },
}
