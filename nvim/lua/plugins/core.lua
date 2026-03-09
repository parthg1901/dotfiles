-- Core plugins: LSP, Treesitter, Completion, Mason
return {
  -- Completion engine (blink.cmp - faster, Rust-based)
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    event = "InsertEnter",
    config = function()
      require("config.blink-cmp")
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp")
    end,
  },

  -- TypeScript tools (faster than tsserver, better actions)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      on_attach = function(client, bufnr)
        -- Keymaps for TypeScript-specific actions
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, silent = true, desc = desc })
        end
        map("n", "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", "Organize imports")
        map("n", "<leader>ts", "<cmd>TSToolsSortImports<cr>", "Sort imports")
        map("n", "<leader>tu", "<cmd>TSToolsRemoveUnusedImports<cr>", "Remove unused imports")
        map("n", "<leader>td", "<cmd>TSToolsGoToSourceDefinition<cr>", "Go to source definition")
        map("n", "<leader>tr", "<cmd>TSToolsRenameFile<cr>", "Rename file")
        map("n", "<leader>ti", "<cmd>TSToolsAddMissingImports<cr>", "Add missing imports")
        map("n", "<leader>ta", "<cmd>TSToolsFixAll<cr>", "Fix all")
      end,
    },
  },

  -- LSP references/definitions preview
  {
    "dnlhc/glance.nvim",
    config = function()
      require("config.glance")
    end,
    event = "VeryLazy",
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },

  -- Treesitter text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    branch = "master",
    config = function()
      require("config.treesitter-textobjects")
    end,
  },

  -- Mason plugin manager for LSP, DAP, Linters, and Formatters
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Common dependency
  { "nvim-lua/plenary.nvim", lazy = true },
}
