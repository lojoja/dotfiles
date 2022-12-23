# dotfiles/zsh/custom/fzf.zsh
# shellcheck shell=zsh disable=1090

if [[ $MACPORTS_PREFIX != "" ]]
then
  # Auto-completion
  if [[ $- == *i* ]]
  then
    completion="${MPOPT}/fzf/shell/completion.zsh"

    if [[ -r $completion ]]
    then
      source "$completion"
    fi

    unset completion
  fi

  # Key bindings
  bindings="${MPOPT}/fzf/shell/key-bindings.zsh"

  if [[ -r $bindings ]]
  then
    source "$bindings"
  fi

  unset bindings
fi
