#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_PACKAGES=(git tmux eza zoxide fzf starship stow)

install_mac_packages() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "[ERROR] Homebrew is required on macOS. Install it from https://brew.sh first." >&2
    exit 1
  fi

  echo "[INFO] Installing Homebrew formulae: ${DEFAULT_PACKAGES[*]}"
  brew install "${DEFAULT_PACKAGES[@]}"

  if ! command -v wezterm >/dev/null 2>&1; then
    echo "[INFO] Installing WezTerm via Homebrew cask"
    brew install --cask wezterm
  fi
}

install_apt_packages() {
  if [ ! -r /etc/os-release ]; then
    echo "[ERROR] Cannot detect Linux distribution (missing /etc/os-release)." >&2
    exit 1
  fi

  # shellcheck disable=SC1091
  . /etc/os-release

  case "${ID_LIKE:-$ID}" in
    *debian*) ;;
    *)
      echo "[ERROR] This setup script currently supports Debian/Ubuntu only." >&2
      exit 1
      ;;
  esac

  echo "[INFO] Updating apt package index"
  sudo apt-get update

  echo "[INFO] Installing packages: ${DEFAULT_PACKAGES[*]}"
  sudo apt-get install -y "${DEFAULT_PACKAGES[@]}"

  if ! command -v wezterm >/dev/null 2>&1; then
    cat <<'MSG'
[WARN] wezterm is not available from the default Ubuntu/Debian repositories.
       Install it manually from https://wezfurlong.org/wezterm/ if you need it.
MSG
  fi
}

run_stow() {
  if [ "$#" -eq 0 ]; then
    cat <<'INFO'
[INFO] No stow packages specified. Example usage:
  ./setup.sh zsh tmux
INFO
    return 0
  fi

  if ! command -v stow >/dev/null 2>&1; then
    echo "[ERROR] GNU stow is not available. Install it first (it's part of the default packages)." >&2
    exit 1
  fi

  echo "[INFO] Stowing packages: $*"
  (cd "$DOTFILES_DIR" && stow -t "$HOME" "$@")
}

main() {
  local sysname
  sysname="$(uname -s)"

  case "$sysname" in
    Darwin)
      install_mac_packages
      ;;
    Linux)
      install_apt_packages
      ;;
    *)
      echo "[ERROR] Unsupported operating system: $sysname" >&2
      exit 1
      ;;
  esac

  run_stow "$@"

  cat <<'DONE'
[INFO] Setup complete.
- Start a new shell session to load the updated configuration after stowing.
- For tmux plugins, run TPM's install shortcut once tmux is up.
DONE
}

main "$@"
