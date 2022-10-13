# dotfiles/bash/prompt.sh
# shellcheck shell=bash

dotfilesCurrentRepo() {
  # Format working directory repository status for bash prompt
  if hash vcprompt &>/dev/null
  then
    vcprompt -f " ${BLACK_BOLD}[${BLACK}repo ${BLUE}%n${BLACK_BOLD}:${YELLOW}%b${GREEN}%m%u${BLACK_BOLD}]"
  fi
}

dotfilesCurrentVENV() {
  # Format the current virtual env for bash prompt
  local folder name

  if [[ x${VIRTUAL_ENV} != x ]]
  then

    if [[ -r "$VIRTUAL_ENV/pyvenv.cfg" ]] # Poetry-style virtualenv prompt
    then
      name=$(sed -n -e 's|^prompt\s*=\s*\(.*\)$|\1|p' < .venv/pyvenv.cfg)
    else
      folder="$(dirname "$VIRTUAL_ENV")"
      name="$(basename "$folder")/$(basename "$VIRTUAL_ENV")"
    fi

    printf " %s[%svenv %s%s%s]" "$BLACK_BOLD" "$BLACK" "$BLUE" "$name" "$BLACK_BOLD"
  fi

  stty werase undef
  bind '"\C-w": unix-filename-rubout'
}

dotfilesPreviousCommandStatus() {
  # Format last command exit status for bash prompt
  local code=$?

  if [[ $code -ne 0 ]]
  then
    printf " %s[%sexited %s%s%s]" "$BLACK_BOLD" "$BLACK" "$RED" "$code" "$BLACK_BOLD"
  fi
}

PROMPT_COMMAND='PS1="\[\e[G\]${RESET}\007\n\
${MAGENTA}\u${BLACK_BOLD}@${YELLOW}\h\
$(dotfilesPreviousCommandStatus)$(dotfilesCurrentRepo)$(dotfilesCurrentVENV)\
${BLACK_BOLD}: ${GREEN}\w${RESET}\n$ "'
