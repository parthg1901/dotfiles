return {
  cmd = { "vscode-json-languageserver", "--stdio" },
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = { "next.config.js", "next.config.mjs" },
          url = "https://json.schemastore.org/nextjs-config.json",
        },
        {
          fileMatch = { "tailwind.config.js", "tailwind.config.ts" },
          url = "https://json.schemastore.org/tailwind.config.json",
        },
        {
          fileMatch = { "eslintrc.json", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
      },
      validate = { enable = true },
      format = { enable = true },
    },
  },
} 