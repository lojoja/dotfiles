# dotfiles/shared/shell/custom/pip.sh
# shellcheck shell=bash

export PIP_CONFIG_FILE="$DOTFILES_INSTALLED_CONFIG_PATH/pip.conf"

if [[ $MACPORTS_PREFIX != "" ]]
then
  function pipPriv() {
    local account=$1
    local name=$2
    local host

    if [[ $USER = 'jl' ]]
    then
      if [[ $account = 'snldev' ]]
      then
        host="gh-snldev"
      else
        host="gh"
      fi
    else
      if [[ $account = 'snldev' ]]
      then
        host="gh"
      else
        host="gh-lojoja"
      fi
    fi

    local url="git+ssh://$host:/$account/$name.git"
    local venv="$HBOPT/$account/$name"
    local cmd="$HBBIN/$name"

    if [[ -d "$venv" ]]
    then
      "$MPBIN/python3" -m venv --upgrade "$venv"
    else
      "$MPBIN/python3" -m venv --copies "$venv"
    fi

    "$venv/bin/pip" install "$url" --no-cache-dir --no-binary :all:

    if [[ ! -r $cmd ]]
    then
      ln -s "$venv/bin/$name" "$cmd"
    fi
  }
fi
