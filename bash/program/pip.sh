# dotfiles/bash/program/pip.sh

export PIP_CONFIG_FILE="$DOTFILES/pip/pip.conf"

function pipPriv() {
  local user=$1
  local repo=$2

  if [[ $user = 'snldev' ]]
  then
    local host='gh-snldev'
  else
    local host='gh'
  fi

  local url="git+ssh://$host:/$user/$repo.git"
  local venv="/usr/local/opt/$user/$repo"

  if [[ -d "$venv" ]]
  then
    /usr/local/bin/python3 -m venv --upgrade "$venv"
  else
    /usr/local/bin/python3 -m venv --copies "$venv"
  fi

  "$venv/bin/pip" install "$url" --no-cache-dir --no-binary :all:

  if ! [[ -r "/usr/local/bin/$repo" ]]
  then
    ln -s "$venv/bin/$repo" "/usr/local/bin/$repo"
  fi
}
