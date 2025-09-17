
# ========================
# Python Environment (uv)
# ========================

# Add uv-managed Python to PATH
export PATH="$HOME/.local/share/uv/python/cpython-3.12.11-macos-aarch64-none/bin:$PATH"

# ========================
# Enhanced CLI Tools
# ========================

# Eza (better ls)
alias ls="eza --icons=always"

# Zoxide (better cd)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# FZF (fuzzy finder)
command -v fzf >/dev/null 2>&1 && eval "$(fzf --zsh)"

# ========================
# Aliases
# ========================

alias code='open -a "Visual Studio Code"'

# ========================
# Completions
# ========================

eval "$(starship init zsh)"
bindkey -e

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh