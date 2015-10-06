
if [ "$(uname)" == "Darwin"  ]; then
  alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux"  ]; then
  alias ls='ls --color=auto'
  alias update='sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get clean'
fi


# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"
