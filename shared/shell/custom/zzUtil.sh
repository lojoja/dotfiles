# dotfiles/shared/shell/custom/zzUtil.sh
# shellcheck shell=bash

function cliInstall() {
  # Install cli utils by passing "<owner>/<package>" arguments to this function.

  local args=("${@}")
  local python="$MPBIN/python3.10"

  for arg in "${args[@]}"
  do
    local owner="${arg%/*}"
    local package="${arg#*/}"
    local venv="$HBOPT/util/$package"
    local venv_bin="$venv/bin"
    local pip="$venv_bin/pip"

    if [[ $owner = 'lojoja' ]]
    then
      local index="$GITEA_PYPI_PACKAGE_INDEX_LOJOJA"
    elif [[ $owner = 'snldev' ]]
      then
        local index="$GITEA_PYPI_PACKAGE_INDEX_SNLDEV"
    else
      printf "Error: Unknown user %s\n" "$owner" && return 1
    fi

    local pip_args="--extra-index-url=$index"

    if [[ ! -d $venv ]]
    then
      "$python" -m venv "$venv"
    else
      pip_args="$pip_args --upgrade"
    fi

    "$pip" install --upgrade pip
    "$pip" install "$pip_args" "$package"

    for file in "$venv_bin"/*
    do
      local re="^([Aa]ctivate|pip|python).*"

      if [[ ! $file =~ $re ]]
      then
        ln -sf "$venv_bin/$file" "$HBBIN/$file"
      fi
    done
  done
}

function cliUninstall() {
  # Remove cli utils by passing one or more utility names to this function.

  local args=("${@}")

  for arg in "${args[@]}"
  do
    local venv="$HBOPT/util/$arg"

    if [[ -d $venv ]]
    then
      for file in "$venv"/bin/*
      do
        local re="^([Aa]ctivate|pip|python).*"

        if [[ ! $file =~ $re ]]
        then
          if [[ -r $HBBIN/file ]]
          then
            rm "$HBBIN/file"
          fi
        fi
      done

      rm -rf "$venv"
      printf "Uninstalled %s\n" "$arg"
    else
      printf "Error: Unknown util %s\n" "$arg"
    fi
  done
}
