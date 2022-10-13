# dotfiles/bash/custom/python.sh
# shellcheck shell=bash

export PYTHONDONTWRITEBYTECODE=1

if [[ $HOMEBREW_PREFIX != "" ]]
then
  alias py3='$HBBIN/python3'

  upgradeVenv() {
    for venv in "$HBOPT"/{lojoja,snldev}/*; do
      "$HBBIN/python3" -m venv --upgrade --copies "$venv"
    done &>/dev/null
  }
fi
