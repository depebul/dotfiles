
# ========================
# Path setup
# ========================

# Prepend uv-managed Python installations
BREW_PREFIX=""
if [ -d "$HOME/.local/share/uv/python" ]; then
  for _uv_python_bin in "$HOME"/.local/share/uv/python/*/bin; do
    [ -d "$_uv_python_bin" ] || continue
    case ":$PATH:" in
      *:"$_uv_python_bin":*) ;;
      *) PATH="$_uv_python_bin:$PATH" ;;
    esac
  done
  unset _uv_python_bin
fi

# Common local bin directory
if [ -d "$HOME/.local/bin" ]; then
  case ":$PATH:" in
    *:"$HOME/.local/bin":*) ;;
    *) PATH="$HOME/.local/bin:$PATH" ;;
  esac
fi

# macOS Homebrew installs (skip Linuxbrew on Debian/Ubuntu)
case "$(uname -s)" in
  Darwin)
    if command -v brew >/dev/null 2>&1; then
      BREW_PREFIX="$(brew --prefix 2>/dev/null)"
      PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
    fi
    ;;
esac

# ========================
# Enhanced CLI Tools
# ========================

# Eza (better ls)
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=always"
fi

# Zoxide (better cd)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# FZF (fuzzy finder)

# ========================
# Aliases
# ========================

case "$(uname -s)" in
  Darwin)
    alias code='open -a "Visual Studio Code"'
    ;;
esac

# ========================
# Completions & Prompt
# ========================

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

bindkey -e

for _plugin_path in \
  ${BREW_PREFIX:+$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh} \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh; do
  [ -n "$_plugin_path" ] && [ -r "$_plugin_path" ] && source "$_plugin_path" && break
done

for _plugin_path in \
  ${BREW_PREFIX:+$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh} \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  [ -n "$_plugin_path" ] && [ -r "$_plugin_path" ] && source "$_plugin_path" && break
done

unset _plugin_path
