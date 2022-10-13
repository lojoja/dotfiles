# dotfiles/bash/custom/ls.sh
# shellcheck shell=bash

lscolors="$DOTFILES/bash/program/ls.colors"

if [[ -r $lscolors ]]
then
  eval "$(dircolors -b "$lscolors")"
else
  eval "$(dircolors -b)"
fi

unset lscolors

alias l='ls -lah --color=auto'
alias la='ls -lAh --color=auto'
alias ll='ls -lh --color=auto'
alias ls='ls -G --color=auto'
alias lsa='ls -lah --color=auto'
