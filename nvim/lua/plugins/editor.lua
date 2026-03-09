-- Editor plugins: Navigation, Text manipulation, Motion, etc.
return {
  -- Super fast buffer jump
  {
    "smoka7/hop.nvim",
    keys = { "f" },
    config = function()
      require("config.nvim_hop")
    end,
  },

  -- Show match number and index for searching
  {
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { "*", "#", "n", "N" },
    config = function()
      require("config.hlslens")
    end,
  },

  -- Highlight URLs inside vim
  { "itchyny/vim-highlighturl", event = "BufReadPost" },

  -- Automatic insertion and deletion of a pair of characters
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Auto close/rename JSX tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    opts = {},
  },

  -- Better diagnostics list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    opts = {},
  },

  -- Comment plugin (mini.comment - consistent with mini.* ecosystem)
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup()
    end,
  },

  -- Surround plugin (mini.surround - consistent with mini.* ecosystem)
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- Show undo history visually
  { "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" } },

  -- Manage your yank history
  {
    "gbprod/yanky.nvim",
    config = function()
      require("config.yanky")
    end,
    cmd = "YankyRingHistory",
  },

  -- Repeat vim motions
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- Better escape from insert mode
  { "nvim-zh/better-escape.vim", event = { "InsertEnter" } },

  -- Modern matchit implementation
  { "andymass/vim-matchup", event = "BufRead" },

  -- Additional powerful text objects
  { "wellle/targets.vim", event = "VeryLazy" },

  -- Swap arguments
  { "machakann/vim-swap", event = "VeryLazy" },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("config.bqf")
    end,
  },

  -- Show and trim trailing whitespaces
  { "jdhao/whitespace.nvim", event = "VeryLazy" },

  -- Live command preview
  {
    "smjonas/live-command.nvim",
    event = "VeryLazy",
    config = function()
      require("config.live-command")
    end,
  },

  -- Unicode character info
  { "chrisbra/unicode.vim", keys = { "ga" }, cmd = { "UnicodeSearch" } },

  -- XKB switch for Mac
  {
    "lyokha/vim-xkbswitch",
    enabled = function()
      local utils = require("utils")
      return vim.g.is_mac and utils.executable("xkbswitch")
    end,
    event = { "InsertEnter" },
  },

  -- IME for Windows
  {
    "Neur1n/neuims",
    enabled = function()
      return vim.g.is_win
    end,
    event = { "InsertEnter" },
  },
}
