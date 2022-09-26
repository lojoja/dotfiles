# dotfiles/bash/program/python.sh

export PYTHONDONTWRITEBYTECODE=1
export PYTHONSTARTUP="$DOTFILES/python/startup.py"

alias py='python'
alias py2='python'
alias py3='python3'

function upgradeVenv() {
  for venv in /usr/local/opt/{lojoja,snldev}/*; do
    /usr/local/bin/python3 -m venv --upgrade --copies "$venv"
  done
}
