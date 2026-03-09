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

# Desktop file for Claude assistant shortcut
mkdir -p "$HOME/.local/share/applications"
cp "$DOTFILES_DIR/scripts/toggle-claude.desktop" "$HOME/.local/share/applications/"

# Add dots() helper to bashrc if not present
if ! grep -q "dots()" "$HOME/.bashrc" 2>/dev/null; then
    cat >> "$HOME/.bashrc" << 'FUNC'

# Dotfiles quick sync
dots() {
    cd ~/.dotfiles && git add -A && git commit -m "${1:-update dotfiles}" && git push
}
FUNC
fi

echo "Dotfiles linked successfully!"
echo ""
echo "Manual steps:"
echo "  1. Set KDE shortcut: System Settings > Shortcuts > Meta+/ > toggle-claude"
echo "  2. Install fonts: JetBrains Mono Nerd Font"
echo "  3. Install tools: sudo apt install rofi xdotool xclip glow"
echo "  4. In nvim run :Mason to install formatters/debug adapters"
