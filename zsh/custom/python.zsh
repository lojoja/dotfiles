# dotfiles/zsh/custom/python.zsh
# shellcheck shell=zsh

export PYTHONDONTWRITEBYTECODE=1

if [[ $HOMEBREW_PREFIX != "" ]]
then
  alias py3='$HBBIN/python3'

  function upgradeVenv() {
    for venv in "$HBOPT"/{lojoja,snldev}/*; do
      "$HBBIN/python3" -m venv --upgrade --copies "$venv"
    done
  }
fi
