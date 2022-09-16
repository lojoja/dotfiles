# dotfiles/bash/manpath.sh

MANPATH="/usr/share/man"

if [[ $DOTFILES_INIT_BREW_PREFIX != "" ]]
then
  MANPATH="${DOTFILES_INIT_BREW_PREFIX}/share/man:$MANPATH"
  MANPATH="${DOTFILES_INIT_BREW_PREFIX}/opt/sqlite/share/man:$MANPATH"
  MANPATH="${DOTFILES_INIT_BREW_PREFIX}/opt/ruby/share/man:$MANPATH"

  for dir in "${DOTFILES_INIT_BREW_PREFIX}/opt/"*"/libexec/gnuman"
  do
    MANPATH="$dir:$MANPATH"
  done
fi

export MANPATH="$MANPATH"
