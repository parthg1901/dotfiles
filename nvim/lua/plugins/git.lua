-- Git plugins: Fugitive, Gitsigns, Neogit, etc.
return {
  -- Git command inside vim
  {
    "tpope/vim-fugitive",
    event = "User InGitRepo",
    config = function()
      require("config.fugitive")
    end,
  },

  -- Neogit - Magit-like interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    event = "User InGitRepo",
  },

  -- Better git log display
  { "rbong/vim-flog", cmd = { "Flog" } },

  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("config.git-conflict")
    end,
  },

  -- Git links
  {
    "ruifm/gitlinker.nvim",
    event = "User InGitRepo",
    config = function()
      require("config.git-linker")
    end,
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
    event = "BufRead",
  },

  -- Diff viewer
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen" },
  },
}
