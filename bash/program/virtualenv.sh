# dotfiles/bash/program/virtualenv.sh

export VENV="$HOME/.virtualenvs"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export WORKON_HOME="$VENV"

if [[ $DOTFILES_INIT_BREW_PREFIX -ne "" ]]
then
  if [[ -r $DOTFILES_INIT_BREW_PREFIX/bin/virtualenvwrapper.sh ]]
  then
    source $DOTFILES_INIT_BREW_PREFIX/bin/virtualenvwrapper.sh
  fi
fi
