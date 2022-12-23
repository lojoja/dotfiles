# dotfiles/zsh/custom/zzsh-autosuggestions.zsh
# shellcheck shell=zsh disable=1090

if [[ $MACPORTS_PREFIX != "" ]]
then
  suggestions="$MPOPT/zsh-autosuggestions/zsh-autosuggestions.zsh"

  if [[ -r $suggestions ]]
  then
    source "$suggestions"
  fi

  unset suggestions
fi
