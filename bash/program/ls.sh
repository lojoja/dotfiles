# dotfiles/bash/program/ls.sh

if [[ -r $DOTFILES_INIT_DIRCOLORS ]]
then
  eval "$(dircolors -b $DOTFILES_INIT_DIRCOLORS)"
else
  eval "$(dircolors -b)"
fi

alias lsa='ls -AFhl'
alias lsd='ls -AFhld'
alias ls='ls -Fhl'
