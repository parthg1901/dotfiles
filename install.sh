#!/bin/bash
# Symlink dotfiles to their expected locations

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -sfn "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config/rofi"
for f in "$DOTFILES_DIR"/rofi/*.rasi; do
    ln -sf "$f" "$HOME/.config/rofi/$(basename "$f")"
done

mkdir -p "$HOME/.local/bin"
ln -sf "$DOTFILES_DIR/scripts/toggle-claude" "$HOME/.local/bin/toggle-claude"
chmod +x "$HOME/.local/bin/toggle-claude"

echo "Dotfiles linked successfully!"
