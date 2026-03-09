require("blink.cmp").setup {
  keymap = {
    preset = "default",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<Enter>"] = { "select_and_accept", "fallback" },
    ["<C-U>"] = { "scroll_documentation_up", "fallback" },
    ["<C-D>"] = { "scroll_documentation_down", "fallback" },
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    menu = {
      border = "rounded",
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = "rounded",
      },
    },
    ghost_text = {
      enabled = false,
    },
  },

  signature = {
    enabled = true,
    window = {
      border = "rounded",
    },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },

  cmdline = {
    completion = {
      menu = {
        auto_show = true,
      },
    },
    keymap = {
      ["<Enter>"] = { "select_and_accept", "fallback" },
    },
  },
}
