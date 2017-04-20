# dotfiles/bash/program/virtualenv.sh

export VENV="$HOME/.virtualenvs"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export WORKON_HOME="$VENV"

if hash virtualenvwrapper.sh &>/dev/null
then
  source "`readlink -e virtualenvwrapper.sh`"
fi
