# dotfiles/bash/custom/fzf.sh
# shellcheck shell=bash disable=1090,1091

if [[ $HOMEBREW_PREFIX != "" ]]
then
  # Auto-completion
  if [[ $- == *i* ]]
  then
    completion="${HBOPT}/fzf/shell/completion.bash"

    if [[ -r $completion ]]
    then
      source "$completion"
    fi

    unset completion
  fi

  # Key bindings
  bindings="${HBOPT}/fzf/shell/key-bindings.bash"

  if [[ -r $bindings ]]
  then
    source "$bindings"
  fi

  unset bindings
fi
