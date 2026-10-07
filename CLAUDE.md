# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for a terminal-first development environment on macOS. Components:

- **Neovim** (`nvim/`) — the primary and most complex component
- **Tmux** (`tmux/`) — config plus one theme file per colorscheme variant
- **Git** (`git/gitconfig`, `git/gitignore_global`) — git config with extensive aliases
- **Shell** (`bash_profile`, `bash_aliases`, `bash_prompt`, `starship.toml`) — bash + starship prompt
- **IdeaVim** (`ideavimrc`) — Vim keybindings for IntelliJ products
- **Claude Code** (`claude/`) — user-level settings, statusline script, coding guidelines (`java.md`, `frontend.md`) and skills

There is no Kitty config in this repo.

## Setup

There is no install script. Config files are symlinked manually to their expected locations; `README.md` lists the symlink commands and external dependencies. Keep it in sync when adding or moving config files.

Neovim plugins are managed by **lazy.nvim** and auto-install on first launch. To update plugins headlessly:
```
nvim --headless "+Lazy! sync" +qa
```
`nvim/lazy-lock.json` is gitignored, so plugin versions are not pinned in the repo.

## Conventions

- Every `.lua` file under `nvim/` ends with the modeline `-- vim: ts=2 sts=2 sw=2 et`. Keep it when editing and add it to new files.
- Lua is formatted with **stylua** (format-on-save via conform.nvim); files use tabs for indentation.
- Comments in config files are often in Norwegian; follow the language of the surrounding code.

## Neovim architecture

Originally based on **kickstart.nvim**, but the kickstart plugin set has been fully split out — there is no `lua/kickstart/` directory anymore.

- `nvim/init.lua` — core options, base keymaps, autocmds (treesitter folding, yank highlight), lazy.nvim bootstrap. Lazy setup loads only `tpope/vim-sleuth` and `{ import = "custom.plugins" }`.
- `nvim/lua/custom/plugins/` — one file per plugin/feature, each returning a lazy.nvim spec. Every file here is auto-imported, so adding a plugin = adding a file.
- `nvim/lua/custom/plugins/colorschemes/` — subdirectory, imported via its `init.lua` (lazy.nvim's `import` loads the directory module).
- `nvim/after/ftplugin/` — filetype overrides: `java.lua` (custom fold expression folding imports + indent), `markdown.lua` / `text.lua` (wrap, linebreak, `j`/`k` → `gj`/`gk`).

**Key settings:** Leader `<Space>`, `conceallevel=2`, clipboard `unnamedplus`, relative numbers, all folds open by default (`foldlevel=99`). Folding uses treesitter `foldexpr` when a parser exists, otherwise `indent`; Java is skipped there because its ftplugin sets its own fold expression.

**Plugins** (`lua/custom/plugins/`):
- `lsp.lua` — nvim-lspconfig + Mason, mason-lspconfig, mason-tool-installer, fidget. Servers: `ts_ls`, `jdtls`, `html`, `cssls`, `dockerls`, `jsonls`, `yamlls`, `lua_ls`. `jdtls` goes through `nvim-java` and references a hard-coded formatter XML path on a work machine (`/Users/k37597/...`). LSP keymaps (`gd`, `gr`, `gI`, `<leader>rn`, `<leader>ca`, …) are set in an `LspAttach` autocmd and use Telescope pickers.
- `autocompletion.lua` — nvim-cmp + LuaSnip (sources: lazydev, nvim_lsp, luasnip, path)
- `conform.lua` — format on save; stylua (lua), jq (json), prettierd/prettier (html, js). `<leader>fb` formats manually.
- `telescope.lua` — fuzzy finder, `<leader>s*` keymaps, vertical layout
- `treesitter.lua` — parsers, highlighting, incremental selection, and the textobject definitions (`treesitter-textobjects.lua` only declares the plugin)
- `mini.lua` — mini.ai, mini.surround, mini.statusline
- Git: `gitsigns.lua`, `fugitive.lua`, `neogit.lua` (`<leader>gg`)
- `harpoon.lua` — harpoon2; `<leader>a` add, `<leader>l` menu, `<C-j>`/`<C-k>` prev/next. **Note:** these override the `<C-j>`/`<C-k>` window-navigation maps from `init.lua`.
- `nvim-tree.lua` — file explorer (`<leader>n`)
- `which-key.lua` — keymap discovery; documents leader groups
- `render-markdown.lua` — in-editor markdown rendering
- `journal.lua` — `orose/journal.nvim` (the user's own plugin)
- `vimdeck.lua` — presentations inside Neovim
- `lazydev.lua`, `todo-comments.lua`

## Theming

Four colorschemes: **Modus** (current default), **Catppuccin**, **Rose Pine** and **Solarized**.

**Neovim:** `colorschemes/init.lua` sets `ACTIVE_THEME` (matched against each spec's `name`). Each theme file returns a lazy spec with extra fields `dark_colorscheme` / `light_colorscheme` (or a single `colorscheme`). The loader gives the active theme `priority = 1000`, wraps its `config` and, when both dark/light are set, adds `f-person/auto-dark-mode.nvim` to follow the macOS appearance. To switch theme, change `ACTIVE_THEME`.

**Tmux:** `tmux.conf` sources `~/.tmux-theme.conf`, which is expected to be a symlink/copy of one of `tmux/tmux-theme-<scheme>-<variant>.conf`. Theme files use a two-layer variable scheme:
- `@thm_*` — raw palette hex values
- `@cfg_*` — semantic roles (`@cfg_bg`, `@cfg_fg`, `@cfg_accent`, `@cfg_pane_title`, `@cfg_date`, `@cfg_window_last`), set with `set -gqF` so they resolve to concrete values

`tmux.conf` only references `@cfg_*`. A new theme file must define all `@cfg_*` variables.

**Starship:** `starship.toml` has a pill-style prompt with a `palette` setting (currently `modus_operandi`) and palette definitions at the bottom of the file.

## Tmux

Prefix is `Ctrl-a`. Vi copy mode, mouse on, status bar at the top (with an empty second line), windows/panes indexed from 1. Splits: `|` horizontal, `-` vertical; `h/j/k/l` select pane, `H/J/K/L` resize, `<`/`>` swap windows, `r` reloads config.

## Claude Code config (`claude/`)

- `settings.json` — user settings (statusline, language Norsk, permissions)
- `statusline-command.sh` — statusline showing model, dir, git branch/changes, context bar, cost converted to NOK and duration (needs `jq` and `bc`)
- `java.md`, `frontend.md` — personal coding guidelines for Java/Spring Boot and React/TypeScript projects
- `skills/` — custom skills; `skills/synced/` (untracked, has a `manifest.json`) appears to be synced automatically and should not be edited by hand
