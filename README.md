# Dotfiles

Personal configuration for a terminal-first development environment on macOS:
Neovim, tmux, Ghostty, git, bash/starship, IdeaVim and Claude Code.

## Contents

| Path | What |
| --- | --- |
| `nvim/` | Neovim config (kickstart.nvim-based, plugins via lazy.nvim) |
| `tmux/` | `tmux.conf` and one theme file per colorscheme variant |
| `ghostty/` | Ghostty terminal config |
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

# Ghostty
mkdir -p ~/.config/ghostty
ln -s $DOT/ghostty/config ~/.config/ghostty/config

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

- [Neovim](https://neovim.io) 0.11+ (uses the native `vim.lsp.config` API) and a [Nerd Font](https://www.nerdfonts.com)
  (Ghostty is set up for FiraCode Nerd Font Mono)
- [Ghostty](https://ghostty.org)
- `git`, `make` and a C compiler (treesitter parsers, telescope-fzf-native)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (Telescope live grep)
- [starship](https://starship.rs)
- `jq` and `bc` (Claude Code statusline, JSON formatting)
- Node.js via [nvm](https://github.com/nvm-sh/nvm) (some language servers and prettier)
- `reattach-to-user-namespace` (tmux clipboard bindings)
- A JDK and Maven (Java LSP via nvim-java, running/debugging JUnit and Cucumber tests)

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
- `lua/custom/` — helper modules (`cucumber.lua`, `java_test.lua`)
- `after/ftplugin/` — filetype-specific settings (Java, Cucumber, Markdown, text)

Leader is `<Space>`. Press it and wait for which-key to list available keymaps.

### Debugging and tests

nvim-dap with dap-ui is set up for Java. The Java debug adapter and test runner
come from nvim-java, which starts with jdtls, so open a `.java` file first.

| Key | Action |
| --- | --- |
| `<F5>` / `<S-F5>` | Start or continue / stop |
| `<F1>` / `<F2>` / `<F3>` | Step into / over / out |
| `<F7>` | Show or hide dap-ui |
| `<leader>b` / `<leader>B` | Toggle breakpoint / conditional breakpoint |

Test keymaps live under `<leader>T` and are buffer-local:

- **Java files (JUnit via nvim-java):** `Tc` / `Tm` run class / method, `TC` / `TM` debug
  class / method, `Tr` show last report, `Tl` re-run last Cucumber run.
  This also works for Cucumber `@Suite` runner classes.
- **`.feature` files (Cucumber via Maven):** `Ts` run scenario under cursor (or
  the Examples row), `Tf` run file, `Tl` re-run last, `Td` / `TD` debug scenario / file.
  Debugging starts Maven with JDWP on port 5005 and attaches the debugger
  automatically. Set `glue` in `custom.cucumber`'s `M.config` if it is not set
  in `junit-platform.properties`.

`jdtls` uses a formatter XML at a hard-coded path on a work machine
(see `lua/custom/plugins/lsp.lua`). Change or remove it on other machines.

## Themes

Supported colorschemes: **Gruvbox Material**, **Modus**, **Catppuccin**, **Rose Pine** and **Solarized**.
Neovim uses Gruvbox Material. Ghostty, the starship palette and the tmux example above use Modus.

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
