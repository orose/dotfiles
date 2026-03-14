# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles managing a terminal-first development environment. The main components are:

- **Neovim** (`nvim/`) — the primary and most complex component
- **Tmux** (`tmux/`) — terminal multiplexer with matching colorschemes
- **Kitty** (`kitty/`) — terminal emulator config
- **Git** (`git/gitconfig`) — git config with extensive aliases
- **Shell** (`bash_profile`, `bash_aliases`, `bash_prompt`, `starship.toml`) — bash + starship prompt
- **IdeaVim** (`ideavimrc`) — Vim keybindings for IntelliJ products

## Setup

There is no install script. Config files are symlinked manually to their expected locations. Neovim plugins are managed by **lazy.nvim** and auto-install on first `nvim` launch.

To update all plugins and reflect changes in `lazy-lock.json`:
```
nvim --headless "+Lazy! sync" +qa
```

## Neovim architecture

Uses **kickstart.nvim** as the base, with the main config split across:

- `nvim/init.lua` — bootstrap, core settings, base keymaps, and lazy.nvim initialization
- `nvim/lua/custom/plugins/` — one file per plugin or feature group (LSP, telescope, treesitter, etc.)
- `nvim/lua/kickstart/plugins/` — optional kickstart-provided plugins (debug, lint, etc.)
- `nvim/after/ftplugin/` — filetype-specific overrides

**Key settings** (from `init.lua`):
- Leader: `<Space>`
- Treesitter-based folding
- Concealment level 2 (affects markdown rendering)

**Custom plugin files** in `lua/custom/plugins/`:
- `lsp.lua` — Mason + mason-lspconfig, language servers, nvim-java/spring-boot
- `autocompletion.lua` — nvim-cmp + LuaSnip
- `telescope.lua` — fuzzy finder keymaps
- `treesitter.lua` and `treesitter-textobjects.lua` — syntax and text objects
- `which-key.lua` — keymap discovery
- `harpoon.lua` — quick file switching (harpoon2 branch)
- `nvim-tree.lua` — file explorer
- `obsidian.nvim` and `journal.nvim` — note-taking
- `render-markdown.lua` — in-editor markdown preview
- `colorschemes/` — Catppuccin, Rose Pine, Solarized configs

## Tmux

Config at `tmux/tmux.conf`. Prefix is `Ctrl-a`. Loads a separate theme file from `~/.tmux-theme.conf` (not tracked here, generated externally to match the active colorscheme).

## Theming

Three supported colorschemes: **Catppuccin**, **Rose Pine**, and **Solarized**. Each has corresponding configs in Neovim's `colorschemes/` directory and matching Tmux/Kitty theme files (managed outside this repo).
