-- Plugin loader: imports all plugin modules
-- This file is loaded by viml_conf/plugins.vim

local plugin_dir = vim.fn.stdpath("data") .. "/lazy"
local lazypath = plugin_dir .. "/lazy.nvim"

-- Bootstrap lazy.nvim
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with modular plugin specs
---@diagnostic disable-next-line: missing-fields
require("lazy").setup {
  spec = {
    { import = "plugins.core" },
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.git" },
    { import = "plugins.tools" },
  },
  ui = {
    border = "rounded",
    title = "Plugin Manager",
    title_pos = "center",
  },
  rocks = {
    enabled = false,
    hererocks = false,
  },
}
