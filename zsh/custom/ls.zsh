# dotfiles/zsh/custom/ls.zsh
# shellcheck shell=zsh

lscolors="$DOTFILES/shared/ls.colors"

if [[ -r $lscolors ]]
then
  eval "$(dircolors -b "$lscolors")"
else
  eval "$(dircolors -b)"
fi

unset lscolors

alias ls='ls --color=auto'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias lsa='l'