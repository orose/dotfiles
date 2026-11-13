# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for a terminal-first development environment on macOS. Components:

- **Neovim** (`nvim/`) — the primary and most complex component
- **Tmux** (`tmux/`) — config plus one theme file per colorscheme variant
- **Git** (`git/gitconfig`, `git/gitignore_global`) — git config with extensive aliases
- **Shell** (`bash_profile`, `bash_aliases`, `bash_prompt`, `starship.toml`) — bash + starship prompt
- **IdeaVim** (`ideavimrc`) — Vim keybindings for IntelliJ products
- **Ghostty** (`ghostty/config`) — terminal config: Gruvbox Material theme following the macOS appearance, FiraCode Nerd Font, background opacity/blur (`cmd+shift+o` toggles opacity), non-native fullscreen (no title/tab bar)
- **Claude Code** (`claude/`) — user-level settings, statusline script, coding guidelines (`java.md`, `frontend.md`) and skills

There is no Kitty config in this repo; the terminal is Ghostty.

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
- `nvim/lua/custom/plugins/` — one file per plugin/feature, each returning a lazy.nvim spec. Every file here is auto-imported, so adding a plugin = adding a file. `init.lua` there is an empty spec (`return {}`).
- `nvim/lua/custom/plugins/colorschemes/` — subdirectory, imported via its `init.lua` (lazy.nvim's `import` loads the directory module).
- `nvim/lua/custom/` — non-plugin helper modules required from plugin specs and ftplugins:
  - `cucumber.lua` — runs/debugs Cucumber scenarios from a `.feature` buffer via Maven (`mvnw` if present) using the JUnit Platform cucumber engine (`-Dcucumber.features=<file>:<line>`). Output goes to a terminal split at the bottom. Debug starts Maven with `-Dmaven.surefire.debug` (JDWP on port 5005, `suspend=y`) and attaches nvim-dap when the JVM prints "Listening for transport dt_socket". Options in `M.config` (`glue`, `plugin`, `debug_port`, `extra_args`). `scenario_line` resolves the scenario (or Examples row) under the cursor, with English and Norwegian Gherkin keywords.
  - `java_test.lua` — DAP listeners for nvim-java test sessions (config name `"Launch All Java Tests"`): notifies on start, opens dap-ui on first output, and after `terminated` summarizes passed/failed/skipped from `java-test`'s last report (opens the report on failures).
- `nvim/after/ftplugin/` — filetype overrides:
  - `java.lua` — custom fold expression (folds imports + indent) and buffer-local test maps under `<leader>T` via nvim-java (`Tc`/`Tm` run class/method, `TC`/`TM` debug class/method, `Tr` last report, `Tl` re-run last Cucumber run)
  - `cucumber.lua` — buffer-local maps for `custom.cucumber` (`Ts` scenario, `Tf` file, `Tl` re-run last, `Td`/`TD` debug scenario/file)
  - `markdown.lua` / `text.lua` — wrap, linebreak, `j`/`k` → `gj`/`gk`

**Key settings:** Leader `<Space>`, `conceallevel=2`, clipboard `unnamedplus`, relative numbers, all folds open by default (`foldlevel=99`). Folding uses treesitter `foldexpr` when a parser exists, otherwise `indent`; Java is skipped there because its ftplugin sets its own fold expression.

**Plugins** (`lua/custom/plugins/`):
- `lsp.lua` — nvim-lspconfig + Mason, mason-lspconfig (v2), mason-tool-installer, fidget, nvim-java. Servers: `ts_ls`, `jdtls`, `html`, `cssls`, `dockerls`, `jsonls`, `yamlls`, `cucumber_language_server`, `lua_ls` (all plus `stylua` are in mason-tool-installer's `ensure_installed`). Uses the native `vim.lsp.config(name, opts)` API per server, then `mason-lspconfig.setup()` enables installed servers automatically (`automatic_enable`) — there are no `handlers`. `require("java").setup()` must run before jdtls is enabled: nvim-java registers the jdtls config with the java-debug/java-test bundles and sets up the DAP adapter on attach. The `jdtls` settings reference a hard-coded formatter XML path on a work machine (`/Users/k37597/...`, profile `Skatteetaten`). LSP keymaps (`gd`, `gr`, `gI`, `gD`, `<leader>D`, `<leader>ds`, `<leader>ws`, `<leader>rn`, `<leader>ca`, `<leader>th` inlay hints) are set in an `LspAttach` autocmd and use Telescope pickers.
- `dap.lua` — nvim-dap + nvim-dap-ui (+ nvim-nio) + nvim-dap-virtual-text, lazy-loaded on its keys: `<F5>` continue, `<S-F5>` terminate, `<F1>`/`<F2>`/`<F3>` step into/over/out, `<F7>` toggle UI, `<leader>b` / `<leader>B` (conditional) breakpoint. dap-ui opens on `initialized` but is not closed automatically, so test output stays visible. The Java adapter comes from nvim-java, not from this file; `config` calls `require("custom.java_test").setup()`.
- `autocompletion.lua` — nvim-cmp + LuaSnip (sources: lazydev, nvim_lsp, luasnip, path)
- `conform.lua` — format on save; stylua (lua), jq (json), prettierd/prettier (html, js). `<leader>fb` formats manually.
- `telescope.lua` — fuzzy finder, `<leader>s*` keymaps, vertical layout
- `treesitter.lua` — parsers, highlighting, incremental selection, and the textobject definitions (`treesitter-textobjects.lua` only declares the plugin)
- `mini.lua` — mini.ai, mini.surround, mini.statusline
- Git: `gitsigns.lua`, `fugitive.lua`, `neogit.lua` (`<leader>gg`)
- `harpoon.lua` — harpoon2; `<leader>a` add, `<leader>l` menu, `<C-j>`/`<C-k>` prev/next. **Note:** these override the `<C-j>`/`<C-k>` window-navigation maps from `init.lua`.
- `nvim-tree.lua` — file explorer (`<leader>n`)
- `which-key.lua` — keymap discovery; documents leader groups (incl. `<leader>T` [T]est; `<leader>t` is [T]oggle)
- `render-markdown.lua` — in-editor markdown rendering
- `journal.lua` — `orose/journal.nvim` (the user's own plugin)
- `vimdeck.lua` — presentations inside Neovim
- `lazydev.lua`, `todo-comments.lua`

## Theming

Five colorschemes: **Gruvbox Material**, **Modus**, **Catppuccin**, **Rose Pine** and **Solarized**. Neovim (`ACTIVE_THEME`), Ghostty and starship use Gruvbox Material.

**Neovim:** `colorschemes/init.lua` sets `ACTIVE_THEME` (matched against each spec's `name`). Each theme file returns a lazy spec with extra fields `dark_colorscheme` / `light_colorscheme` (or a single `colorscheme`). The loader gives the active theme `priority = 1000`, wraps its `config` and, when both dark/light are set, adds `f-person/auto-dark-mode.nvim` to follow the macOS appearance. To switch theme, change `ACTIVE_THEME`.

**Tmux:** `tmux.conf` sources `~/.tmux-theme.conf`, which is expected to be a symlink/copy of one of `tmux/tmux-theme-<scheme>-<variant>.conf`. Theme files use a two-layer variable scheme:
- `@thm_*` — raw palette hex values
- `@cfg_*` — semantic roles (`@cfg_bg`, `@cfg_fg`, `@cfg_accent`, `@cfg_pane_title`, `@cfg_date`, `@cfg_window_last`), set with `set -gqF` so they resolve to concrete values

`tmux.conf` only references `@cfg_*`. A new theme file must define all `@cfg_*` variables.

**Starship:** `starship.toml` has a pill-style prompt with a `palette` setting (currently `gruvbox_material_light`) and palette definitions at the bottom of the file.

## Tmux

Prefix is `Ctrl-a`. Vi copy mode, mouse on, status bar at the top (with an empty second line), windows/panes indexed from 1. Splits: `|` horizontal, `-` vertical; `h/j/k/l` select pane, `H/J/K/L` resize, `<`/`>` swap windows, `r` reloads config.

## Claude Code config (`claude/`)

- `settings.json` — user settings (statusline command, language Norsk)
- `statusline-command.sh` — statusline showing model, dir, git branch/changes, context bar, cost converted to NOK and duration (needs `jq` and `bc`)
- `java.md`, `frontend.md` — personal coding guidelines for Java/Spring Boot and React/TypeScript projects
- `skills/` — custom skills: `grill-me`, `improve-codebase-architecture`, `tdd`, `to-issues`, `to-prd`. A `skills/synced/` directory (untracked, with a `manifest.json`) may appear locally; it is synced automatically and should not be edited by hand
