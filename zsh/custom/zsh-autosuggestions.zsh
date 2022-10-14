# dotfiles/zsh/custom/zzsh-autosuggestions.zsh
# shellcheck shell=zsh disable=1090

if [[ $HOMEBREW_PREFIX != "" ]]
then
  suggestions="$HBOPT/zsh-autosuggestions/zsh-autosuggestions.zsh"

  if [[ -r $suggestions ]]
  then
    source "$suggestions"
  fi

  unset suggestions
fi
