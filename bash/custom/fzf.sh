# dotfiles/bash/custom/fzf.sh
# shellcheck shell=bash disable=1090,1091

if [[ $MACPORTS_PREFIX != "" ]]
then
  # Auto-completion
  if [[ $- == *i* ]]
  then
    completion="${MPOPT}/fzf/shell/completion.bash"

    if [[ -r $completion ]]
    then
      source "$completion"
    fi

    unset completion
  fi

  # Key bindings
  bindings="${MPOPT}/fzf/shell/key-bindings.bash"

  if [[ -r $bindings ]]
  then
    source "$bindings"
  fi

  unset bindings
fi
