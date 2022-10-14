# dotfiles/zsh/custom/fzf.zsh
# shellcheck shell=zsh disable=1090

if [[ $HOMEBREW_PREFIX != "" ]]
then
  # Auto-completion
  if [[ $- == *i* ]]
  then
    completion="${HBOPT}/fzf/shell/completion.zsh"

    if [[ -r $completion ]]
    then
      source "$completion"
    fi

    unset completion
  fi

  # Key bindings
  bindings="${HBOPT}/fzf/shell/key-bindings.zsh"

  if [[ -r $bindings ]]
  then
    source "$bindings"
  fi

  unset bindings
fi
