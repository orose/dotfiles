export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="/Users/orose/bin/apache-maven-3.3.3/bin:${PATH}"

export NVM_DIR="/Users/orose/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
fi
