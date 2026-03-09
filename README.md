# dotfiles

Personal development environment configuration.

## What's included

| Config | Description |
|--------|-------------|
| `nvim/` | Neovim — 73+ plugins, Kanagawa Dragon theme, LSP, DAP debugging, conform.nvim, blink.cmp |
| `kitty/` | Kitty terminal — JetBrains Mono Nerd Font, Kanagawa Dragon colors |
| `tmux/` | Tmux — Ctrl+a prefix, vim-style navigation, Kanagawa theme, dev layout |
| `rofi/` | Rofi themes for Claude assistant popup |
| `scripts/` | `toggle-claude` — rofi-based AI assistant with pin support |

## Install

```bash
git clone git@github.com:parthg1901/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh
```

## Dependencies

```bash
# Core
sudo apt install neovim kitty tmux rofi xdotool xclip

# Fonts
# JetBrains Mono Nerd Font — https://github.com/ryanoasis/nerd-fonts

# Formatters & LSP (install via :Mason in nvim)
# prettierd, stylua, shfmt, debugpy, js-debug-adapter

# Optional
go install github.com/charmbracelet/glow@latest   # markdown rendering for pin
```

## Keybinds

### Tmux (prefix: Ctrl+a)

| Key | Action |
|-----|--------|
| `prefix \|` | Vertical split |
| `prefix -` | Horizontal split |
| `prefix h/j/k/l` | Navigate panes |
| `prefix D` | Dev layout (nvim + claude) |

### Nvim

| Key | Action |
|-----|--------|
| `,` | Leader key |
| `tt` | Toggle transparency |
| `,fm` | Format buffer |
| `<leader>db` | Toggle breakpoint |
| `<leader>dd` | Debug continue |
| `<leader>du` | Toggle DAP UI |
| `<leader>cc` | Copilot Chat |
| `<space>s` | Toggle file tree |
| `f` | Hop (quick jump) |
| `?` | Show all keybindings |

### Desktop

| Key | Action |
|-----|--------|
| `Win + /` | Claude assistant popup |
