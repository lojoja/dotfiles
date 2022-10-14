# dotfiles/zsh/custom/pip.zsh
# shellcheck shell=zsh

export PIP_CONFIG_FILE="$DOTFILES/pip/pip.conf"

if [[ $HOMEBREW_PREFIX != "" ]]
then
  pipPriv() {
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
    local venv="$HBOPT/$user/$name"
    local cmd="$HBBIN/$name"

    if [[ -d "$venv" ]]
    then
      "$HBBIN/python3" -m venv --upgrade "$venv"
    else
      "$HBBIN/python3" -m venv --copies "$venv"
    fi

    "$venv/bin/pip" install "$url" --no-cache-dir --no-binary :all:

    if [[ ! -r $cmd ]]
    then
      ln -s "$venv/bin/$name" "$cmd"
    fi
  }
fi
