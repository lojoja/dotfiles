# dotfiles/bash/program/netstat.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  alias netstat="lsof -i -P"
fi
