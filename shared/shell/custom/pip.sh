# dotfiles/shared/shell/custom/pip.sh
# shellcheck shell=bash

export PIP_CONFIG_FILE="$DOTFILES_INSTALLED_CONFIG_PATH/pip.conf"

if [[ $MACPORTS_PREFIX != "" ]]
then
  function pipPriv() {
    local user=$1
    local name=$2
    local host

    if [[ $user = 'snldev' ]]
    then
      host='gh-snldev'
    else
      host='gh'
    fi

    local url="git+ssh://$host:/$user/$name.git"
    local venv="$MPOPT/$user/$name"
    local cmd="$MPBIN/$name"

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
