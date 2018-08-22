
if [ "$(uname)" == "Darwin"  ]; then
  alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux"  ]; then
  alias ls='ls --color=auto'
  alias update='sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get clean && sudo apt-get autoremove'
fi


# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"

# Run docker tool
alias dockertool="docker run --privileged -v /var/run/docker.sock:/run/docker.sock -ti -e TERM tomastomecek/sen"

# Volume down
alias vdown="amixer -q set Master 2dB- unmute"

# Volume up
alias vup="amixer -q set Master 2dB+ unmute"

