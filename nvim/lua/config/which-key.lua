local wk = require("which-key")

wk.setup {
  preset = "modern",
  icons = {
    mappings = false,
  },
}

-- Register key groups for better discoverability
wk.add({
  -- Leader key groups
  { "<leader>f", group = "Find (fzf)" },
  { "<leader>ff", desc = "Find files" },
  { "<leader>fg", desc = "Grep files" },
  { "<leader>fh", desc = "Help tags" },
  { "<leader>ft", desc = "Buffer tags" },
  { "<leader>fb", desc = "Open buffers" },

  { "<leader>g", group = "Git" },
  { "<leader>gs", desc = "Git status" },
  { "<leader>gw", desc = "Git add file" },
  { "<leader>gc", desc = "Git commit" },
  { "<leader>gpl", desc = "Git pull" },
  { "<leader>gpu", desc = "Git push" },
  { "<leader>gbn", desc = "New branch" },
  { "<leader>gbd", desc = "Delete branch" },
  { "<leader>gf", desc = "Git fetch" },
  { "<leader>gl", desc = "Git permalink" },
  { "<leader>gbr", desc = "Browse repo" },

  { "<leader>h", group = "Hunk (git)" },
  { "<leader>hp", desc = "Preview hunk" },
  { "<leader>hb", desc = "Blame hunk" },

  { "<leader>w", group = "Workspace" },
  { "<leader>wa", desc = "Add workspace folder" },
  { "<leader>wr", desc = "Remove workspace folder" },
  { "<leader>wl", desc = "List workspace folders" },

  { "<leader>r", group = "Refactor/Run" },
  { "<leader>rn", desc = "Rename symbol" },

  { "<leader>t", group = "TypeScript" },
  { "<leader>to", desc = "Organize imports" },
  { "<leader>ts", desc = "Sort imports" },
  { "<leader>tu", desc = "Remove unused imports" },
  { "<leader>td", desc = "Go to source definition" },
  { "<leader>tr", desc = "Rename file" },
  { "<leader>ti", desc = "Add missing imports" },
  { "<leader>ta", desc = "Fix all" },

  { "<leader>x", group = "Trouble" },
  { "<leader>xx", desc = "Diagnostics" },
  { "<leader>xX", desc = "Buffer diagnostics" },
  { "<leader>xs", desc = "Symbols" },
  { "<leader>xq", desc = "Quickfix list" },

  { "<leader>c", group = "Code/Config" },
  { "<leader>ca", desc = "Code action" },
  { "<leader>cl", desc = "Toggle cursor column" },
  { "<leader>cb", desc = "Show cursor blink" },
  { "<leader>cd", desc = "Change to file dir" },

  -- Space key groups
  { "<space>", group = "Quick actions" },
  { "<space>s", desc = "Toggle nvim-tree" },
  { "<space>t", desc = "Toggle Vista (tags)" },
  { "<space>u", desc = "Toggle Mundo (undo)" },
  { "<space>o", desc = "Insert line below" },
  { "<space>O", desc = "Insert line above" },
  { "<space>bp", desc = "Buffer pick" },

  { "<space>g", group = "Glance" },
  { "<space>gd", desc = "Glance definitions" },
  { "<space>gr", desc = "Glance references" },
  { "<space>gi", desc = "Glance implementations" },

  { "<space>q", group = "Quickfix" },
  { "<space>qw", desc = "Window diagnostics to qf" },
  { "<space>qb", desc = "Buffer diagnostics to qf" },

  -- Backslash groups
  { "\\", group = "Buffer/Window" },
  { "\\x", desc = "Close qf/location list" },
  { "\\d", desc = "Delete current buffer" },
  { "\\D", desc = "Delete other buffers" },

  -- Go to groups
  { "g", group = "Go to" },
  { "gd", desc = "Go to definition" },
  { "gb", desc = "Next buffer" },
  { "gB", desc = "Previous buffer" },

  -- Bracket navigation
  { "[", group = "Previous" },
  { "[c", desc = "Previous git hunk" },
  { "[y", desc = "Previous yank entry" },

  { "]", group = "Next" },
  { "]c", desc = "Next git hunk" },
  { "]y", desc = "Next yank entry" },

  -- Fold groups
  { "z", group = "Fold" },
  { "zR", desc = "Open all folds" },
  { "zM", desc = "Close all folds" },
  { "zr", desc = "Open folds except kinds" },
})
