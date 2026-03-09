# JavaScript/TypeScript Development Setup Guide

This guide will help you set up your Neovim configuration for excellent JavaScript/TypeScript development, including Next.js support.

## Prerequisites

### 1. Install Node.js and npm

**Linux/macOS:**
```bash
# Using nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install --lts
nvm use --lts

# Or using package manager
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# macOS
brew install node
```

**Windows:**
```powershell
# Using winget
winget install OpenJS.NodeJS

# Or download from https://nodejs.org/
```

### 2. Install Required Global Packages

```bash
# Install TypeScript language server
npm install -g typescript-language-server typescript

# Install ESLint
npm install -g eslint

# Install Prettier
npm install -g prettier

# Install JSON language server
npm install -g vscode-json-languageserver

# Install Tailwind CSS IntelliSense
npm install -g @tailwindcss/language-server
```

### 3. Install ESLint and Prettier Locally (Recommended)

For each project, install these as dev dependencies:

```bash
npm install --save-dev eslint prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin
```

## Configuration Files

### ESLint Configuration (.eslintrc.js)

```javascript
module.exports = {
  extends: [
    'eslint:recommended',
    '@typescript-eslint/recommended',
    'next/core-web-vitals',
  ],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  root: true,
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  rules: {
    // Add your custom rules here
  },
};
```

### Prettier Configuration (.prettierrc)

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": false,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false
}
```

### TypeScript Configuration (tsconfig.json)

```json
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

## Neovim Features

### LSP Servers

Your configuration now includes:

- **TypeScript Language Server**: Full TypeScript support with IntelliSense
- **ESLint LSP**: Real-time linting and code actions
- **JSON Language Server**: JSON validation and formatting
- **Tailwind CSS IntelliSense**: CSS class autocompletion

### Key Mappings

| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Navigate to function/class definition |
| `K` | Hover documentation | Show type information and docs |
| `<space>rn` | Rename symbol | Rename variables, functions, etc. |
| `<space>ca` | Code actions | Apply quick fixes and refactoring |
| `<leader>rf` | Format file | Format with Prettier/ESLint |
| `<leader>rt` | Run tests | Execute npm/yarn test |
| `<leader>rs` | Start dev server | Start development server |
| `<leader>rb` | Build project | Build the project |

### Snippets

Comprehensive snippets are available for:

- **JavaScript**: Functions, classes, imports, React hooks
- **TypeScript**: Interfaces, types, generics, utility types
- **React**: Components, hooks, JSX patterns
- **Next.js**: Pages, API routes, middleware

### Filetype Support

- `.js` - JavaScript files
- `.ts` - TypeScript files
- `.jsx` - React JSX files
- `.tsx` - React TypeScript files
- `.json` - JSON files with schema validation

## Development Workflow

### 1. Starting a New Next.js Project

```bash
npx create-next-app@latest my-app --typescript --tailwind --eslint
cd my-app
```

### 2. Opening in Neovim

```bash
nvim .
```

### 3. Development Commands

- `<leader>rs` - Start development server
- `<leader>rt` - Run tests
- `<leader>rb` - Build for production
- `<leader>rf` - Format current file

### 4. Code Navigation

- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show documentation
- `<space>ca` - Code actions (quick fixes)

### 5. Refactoring

- `<space>rn` - Rename symbol across files
- `<space>ca` - Extract function/variable
- `<space>ca` - Organize imports

## Troubleshooting

### LSP Not Working

1. Check if language servers are installed:
   ```bash
   which typescript-language-server
   which eslint-lsp
   ```

2. Check LSP status in Neovim:
   ```vim
   :LspInfo
   ```

3. Check for errors:
   ```vim
   :LspLog
   ```

### Formatting Not Working

1. Ensure Prettier is installed:
   ```bash
   npm install -g prettier
   ```

2. Check Prettier configuration in your project

3. Try formatting manually:
   ```vim
   <leader>rf
   ```

### Snippets Not Working

1. Ensure UltiSnips is properly configured
2. Check snippet trigger key: `<C-j>`
3. Verify snippet files are in the correct location

## Advanced Configuration

### Custom LSP Settings

You can customize LSP settings in `after/lsp/tsserver.lua`:

```lua
settings = {
  typescript = {
    inlayHints = {
      includeInlayParameterNameHints = "all",
      includeInlayFunctionParameterTypeHints = true,
    },
  },
}
```

### Custom Key Mappings

Add custom mappings in your filetype configurations:

```vim
" in after/ftplugin/typescript.vim
nnoremap <buffer> <leader>td :call ToggleDebugger()<CR>
```

### Project-Specific Settings

Create `.nvim.lua` in your project root for project-specific settings:

```lua
-- .nvim.lua
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
```

## Performance Tips

1. **Use Tree-sitter**: Syntax highlighting and text objects
2. **Lazy loading**: Plugins load only when needed
3. **Efficient LSP**: Configure debounce and caching
4. **Smart completion**: Configure nvim-cmp for better performance

## Additional Tools

### Recommended Extensions

- **Tailwind CSS**: For utility-first CSS
- **Jest**: For testing
- **Storybook**: For component development
- **Cypress**: For E2E testing

### Useful Commands

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Run tests
npm test

# Lint code
npm run lint

# Format code
npm run format
```

This setup provides a comprehensive development environment for modern JavaScript/TypeScript development with Next.js support. 