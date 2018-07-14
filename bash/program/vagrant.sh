# dotfiles/bash/program/vagrant.sh

if [[ $DOTFILES_INIT_BREW_PREFIX != "" ]]
then
  export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
fi
