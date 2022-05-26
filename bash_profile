export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


[[ -n "$DISPLAY" && "$TERM" = "xterm"  ]] && export TERM=xterm-256color

if [ "$(uname)" == "Darwin"  ]; then
  export NVM_DIR="/Users/orose/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux"  ]; then
  export TERMINAL=rxvt-unicode
  export NVM_DIR="/home/orose/.nvm"

  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files -g "!{node_modules/*,.git/*}"'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
