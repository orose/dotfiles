export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

if [ "$(uname)" == "Darwin"  ]; then
  export NVM_DIR="/Users/orose/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux"  ]; then
  export NVM_DIR="/home/orose/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
fi

if [ "$(expr substr $(uname -s) 1 5)" == "Linux"  ]; then
  export TERMINAL=rxvt-unicode
fi

[[ -n "$DISPLAY" && "$TERM" = "xterm"  ]] && export TERM=xterm-256color

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
