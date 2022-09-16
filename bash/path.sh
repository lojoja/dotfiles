# dotfiles/bash/path.sh

if [[ $DOTFILES_INIT_BREW_PREFIX != "" ]]
then
  PATH="${DOTFILES_INIT_BREW_PREFIX}/sbin:$PATH"
  PATH="${DOTFILES_INIT_BREW_PREFIX}/opt/sqlite/bin:$PATH"
  PATH="${DOTFILES_INIT_BREW_PREFIX}/opt/ruby/bin:$PATH"

  for dir in "${DOTFILES_INIT_BREW_PREFIX}/opt/"*"/libexec/gnubin"
  do
    PATH="$dir:$PATH"
  done

  PATH="${DOTFILES_INIT_BREW_PREFIX}/lib/ruby/gems/3.1.0/bin:$PATH"
fi

PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/share/gem/ruby/3.1.0/bin:$PATH"
export PATH="$PATH"
