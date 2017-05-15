# dotfiles/bash/prompt.sh

dotfilesCurrentRepo() {
  # Format working directory repository status for bash prompt
  local prompt

  if hash vcprompt &>/dev/null
  then
    prompt=" ${BLACK_BOLD}[${BLACK}repo ${BLUE}%n${BLACK_BOLD}:${YELLOW}%b${GREEN}%m%u${BLACK_BOLD}]"
    vcprompt -f "$prompt"
  fi
}

dotfilesCurrentVENV() {
  # Format the current virtual env for bash prompt
  local folder name

  if [ x$VIRTUAL_ENV != x ]
  then
    if [[ $VIRTUAL_ENV == *.virtualenvs/* ]]
    then
      name=`basename "${VIRTUAL_ENV}"`
    else
      folder=`dirname "${VIRTUAL_ENV}"`
      name=`basename "$folder"`
    fi

    printf " ${BLACK_BOLD}[${BLACK}venv ${BLUE}${name}${BLACK_BOLD}]"
  fi

  stty werase undef
  bind '"\C-w": unix-filename-rubout'
}

dotfilesPreviousCommandStatus() {
  # Format last command exit status for bash prompt
  local code=$?

  if [[ $code -ne 0 ]]
  then
    printf " ${BLACK_BOLD}[${BLACK}exited ${RED}${code}${BLACK_BOLD}]"
  fi
}

PROMPT_COMMAND='PS1="\[\e[G\]${RESET}\007\n\
${MAGENTA}\u${BLACK_BOLD}@${YELLOW}\h\
$(dotfilesPreviousCommandStatus)$(dotfilesCurrentRepo)$(dotfilesCurrentVENV)\
${BLACK_BOLD}: ${GREEN}\w${RESET}\n$ "'
