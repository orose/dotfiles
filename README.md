# Dotfiles

Personal configuration for a terminal-first development environment on macOS:
Neovim, tmux, git, bash/starship, IdeaVim and Claude Code.

## Contents

| Path | What |
| --- | --- |
| `nvim/` | Neovim config (kickstart.nvim-based, plugins via lazy.nvim) |
| `tmux/` | `tmux.conf` and one theme file per colorscheme variant |
| `git/` | `gitconfig` (with aliases) and `gitignore_global` |
| `bash_profile`, `bash_aliases`, `bash_prompt` | Bash setup |
| `starship.toml` | Starship prompt |
| `ideavimrc` | Vim keybindings for IntelliJ products |
| `claude/` | Claude Code settings, statusline script, guidelines and skills |

## Installation

There is no install script — clone the repo and symlink what you need.

```sh
git clone https://github.com/orose/dotfiles.git ~/git/dotfiles
cd ~
DOT=~/git/dotfiles

# Neovim
mkdir -p ~/.config
ln -s $DOT/nvim ~/.config/nvim

# tmux (pick one theme file)
ln -s $DOT/tmux/tmux.conf ~/.tmux.conf
ln -s $DOT/tmux/tmux-theme-modus-vivendi.conf ~/.tmux-theme.conf

# git
ln -s $DOT/git/gitconfig ~/.gitconfig
ln -s $DOT/git/gitignore_global ~/.gitignore_global

# shell and prompt
ln -s $DOT/bash_profile ~/.bash_profile
ln -s $DOT/bash_aliases ~/.bash_aliases
ln -s $DOT/bash_prompt ~/.bash_prompt
ln -s $DOT/starship.toml ~/.config/starship.toml

# IdeaVim
ln -s $DOT/ideavimrc ~/.ideavimrc

# Claude Code
mkdir -p ~/.claude
ln -s $DOT/claude/settings.json ~/.claude/settings.json
ln -s $DOT/claude/statusline-command.sh ~/.claude/statusline-command.sh
```

### Dependencies

- [Neovim](https://neovim.io) (recent stable) and a [Nerd Font](https://www.nerdfonts.com)
- `git`, `make` and a C compiler (treesitter parsers, telescope-fzf-native)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (Telescope live grep)
- [starship](https://starship.rs)
- `jq` and `bc` (Claude Code statusline, JSON formatting)
- Node.js via [nvm](https://github.com/nvm-sh/nvm) (some language servers and prettier)
- `reattach-to-user-namespace` (tmux clipboard bindings)

## Neovim

Plugins install automatically on first launch. Language servers and formatters
are installed by Mason (`:Mason`). To update all plugins headlessly:

```sh
nvim --headless "+Lazy! sync" +qa
```

`lazy-lock.json` is gitignored, so plugin versions are not pinned.

Structure:

- `init.lua` — options, base keymaps, lazy.nvim bootstrap
- `lua/custom/plugins/` — one file per plugin; every file is auto-imported
- `lua/custom/plugins/colorschemes/` — theme specs and the theme loader
- `after/ftplugin/` — filetype-specific settings (Java, Markdown, text)

Leader is `<Space>`. Press it and wait for which-key to list available keymaps.

## Themes

Supported colorschemes: **Modus** (default), **Catppuccin**, **Rose Pine** and **Solarized**.

- **Neovim:** set `ACTIVE_THEME` in `nvim/lua/custom/plugins/colorschemes/init.lua`.
  Themes with both dark and light variants follow the macOS appearance automatically.
- **tmux:** point `~/.tmux-theme.conf` at one of `tmux/tmux-theme-*.conf` and
  reload with `prefix + r`.
- **Starship:** change `palette` in `starship.toml`.

## tmux

Prefix is `Ctrl-a`. Highlights:

- `|` / `-` — split horizontally / vertically
- `h j k l` — move between panes, `H J K L` — resize
- `<` / `>` — swap windows, `Ctrl-a` — last window
- `Escape` — copy mode (vi keys), `p` — paste
- `r` — reload config
