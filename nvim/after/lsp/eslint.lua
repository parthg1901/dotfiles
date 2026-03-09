return {
  cmd = { "eslint-lsp", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    eslint = {
      enable = true,
      format = "unix",
      lintTask = {
        enable = true,
      },
      codeActionsOnSave = {
        enable = true,
        mode = "all",
      },
      validate = {
        enable = true,
      },
      workingDirectory = {
        mode = "auto",
      },
    },
  },
  init_options = {
    hostInfo = "neovim",
  },
} 