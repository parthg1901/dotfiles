-- UI plugins: Statusline, Bufferline, Colorscheme, File explorer, etc.
local firenvim_not_active = function()
  return not vim.g.started_by_firenvim
end

return {
  -- Colorschemes
  { "sainnhe/gruvbox-material", lazy = true },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      theme = "dragon",
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "NONE",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Transparent backgrounds
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          FloatTitle = { bg = "NONE" },

          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Telescope
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = "NONE" },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "NONE" },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "NONE" },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "NONE" },
          TelescopePreviewNormal = { bg = "NONE" },
          TelescopePreviewBorder = { bg = "NONE", fg = theme.ui.bg_dim },

          -- Nvim-tree
          NvimTreeNormal = { bg = "NONE" },
          NvimTreeNormalNC = { bg = "NONE" },

          -- Pmenu (completion)
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
  },

  -- Nerdfont icons
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").mock_nvim_web_devicons()
      require("mini.icons").tweak_lsp_kind()
    end,
    lazy = true,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "BufRead",
    cond = firenvim_not_active,
    config = function()
      require("config.lualine")
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    event = { "BufEnter" },
    cond = firenvim_not_active,
    config = function()
      require("config.bufferline")
    end,
  },

  -- Start screen
  {
    "nvimdev/dashboard-nvim",
    cond = firenvim_not_active,
    config = function()
      require("config.dashboard-nvim")
    end,
  },

  -- Indent scope indicator
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      local mini_indent = require("mini.indentscope")
      mini_indent.setup {
        draw = {
          animation = mini_indent.gen_animation.none(),
        },
        symbol = "▏",
      }
    end,
  },

  -- Status column
  {
    "luukvbaal/statuscol.nvim",
    opts = {},
    config = function()
      require("config.nvim-statuscol")
    end,
  },

  -- Code folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {},
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require("config.nvim_ufo")
    end,
  },

  -- Notification plugin
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("config.nvim-notify")
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    keys = { "<space>s" },
    config = function()
      require("config.nvim-tree")
    end,
  },

  -- LSP progress indicator
  {
    "j-hui/fidget.nvim",
    event = "BufRead",
    config = function()
      require("config.fidget-nvim")
    end,
  },

  -- Code actions lightbulb
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("config.lightbulb")
    end,
    event = "LspAttach",
  },

  -- Breadcrumb navigation
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
  },

  -- Color highlighter
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {},
  },

  -- Snacks for better UI
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = {
        enabled = true,
        win = {
          relative = "cursor",
          backdrop = true,
        },
      },
      picker = { enabled = true },
    },
  },

  -- Which-key for keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("config.which-key")
    end,
  },
}
