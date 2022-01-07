# dotfiles/bash/program/pip.sh

export PIP_CONFIG_FILE="$DOTFILES/pip/pip.conf"

function pippriv() {
  local user=$1
  local repo=$2
  local url="git+ssh://git@github.com:/$user/$repo.git"
  local venv="/usr/local/opt/$user/$repo"

  /usr/local/bin/python3 -m venv --copies --upgrade $venv
  $venv/bin/pip install $url --no-cache-dir --no-binary :all:

  if ! [[ -r "/usr/local/bin/$repo" ]]
  then
    ln -s "$venv/bin/$repo" "/usr/local/bin/$repo"
  fi
}
