# dotfiles/bash/program/ls.sh

if [[ -r $DOTFILES_INIT_DIRCOLORS ]]
then
  eval "$(dircolors -b "$DOTFILES_INIT_DIRCOLORS")"
else
  eval "$(dircolors -b)"
fi

alias ls='ls --color=auto'
alias lsa='ls -A --color=auto'
alias lsd='ls -d --color=auto'
alias ll='ls -Fhl --color=auto'
alias lla='ls -AFhl --color=auto'
alias lld='ls -Fhld --color=auto'
