require("nvim-treesitter.configs").setup {
  ensure_installed = {
    -- Original
    "python", "cpp", "lua", "vim", "json", "toml",
    "javascript", "typescript", "tsx", "html", "css", "scss",
    -- Added for better coverage
    "bash", "yaml", "markdown", "markdown_inline",
    "dockerfile", "rust", "go", "vimdoc", "regex", "query",
  },
  ignore_install = {},

  highlight = {
    enable = true,
    disable = { "help" },
    additional_vim_regex_highlighting = false,
  },

  -- Enable treesitter-based indentation
  indent = {
    enable = true,
  },

  -- Incremental selection based on syntax tree
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
}
