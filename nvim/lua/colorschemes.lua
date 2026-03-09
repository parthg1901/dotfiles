--- Colorscheme configuration
local M = {}

M.colorscheme_conf = {
  gruvbox_material = function()
    -- foreground option can be material, mix, or original
    vim.g.gruvbox_material_foreground = "original"
    -- background option can be hard, medium, soft
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_better_performance = 1

    vim.cmd([[colorscheme gruvbox-material]])
  end,

  solarized_osaka = function()
    vim.cmd([[colorscheme solarized-osaka]])
  end,

  catppuccin = function()
    vim.cmd([[colorscheme catppuccin]])
  end,

  kanagawa = function()
    vim.cmd([[colorscheme kanagawa-dragon]])
  end,
}

return M
