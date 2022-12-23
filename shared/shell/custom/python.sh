# dotfiles/shared/shell/custom/python.sh
# shellcheck shell=bash

export PYTHONDONTWRITEBYTECODE=1

if [[ $MACPORTS_PREFIX != "" ]]
then
  alias py3='$MPBIN/python3'

  function upgradeVenv() {
    for venv in "$HBOPT"/{lojoja,snldev}/*; do
      "$MPBIN/python3" -m venv --upgrade --copies "$venv"
    done &>/dev/null
  }
fi
