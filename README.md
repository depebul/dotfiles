# Dotfiles

Bootstrap these dotfiles on macOS, Ubuntu, or Debian with the provided setup script.

## Prerequisites

- macOS: install [Homebrew](https://brew.sh) first.
- Ubuntu/Debian: ensure you have sudo access for `apt`.

## Usage

```bash
./setup.sh              # installs packages only
./setup.sh zsh tmux     # installs packages, then stows the listed packages
```

The script installs the core CLI tools (`git`, `tmux`, `eza`, `zoxide`, `fzf`, `starship`, `stow`).
It installs WezTerm automatically on macOS and reminds you to install it manually on Linux.

Pass any stow package names as arguments once you have them organised (e.g. `zsh`, `tmux`).
No symlinks are created automatically unless you specify packages.

After running the script and stowing your packages, start a new shell session to load the configuration.
