#!/usr/bin/env zsh
#
# An interface for running ansible playbooks to manage a dotfiles installation.

PROGRAM_NAME=dotfiles
REPOSITORY=https://github.com/lojoja/dotfiles
REPOSITORY_PATH="${0:A:h}"
LEGACY_REPOSITORY_PATH="$HOME/.dotfiles"

###############
# Environment #
###############
export PATH="$HOME/.local/bin:$PATH"
export HOMEBREW_NO_ANALYTICS=1

############
# Commands #
############

typeset -A OPT=(
  'help' '-h, --help'
  'test' '-t, --test'
)

typeset -A OPT_DESC=(
  'help' 'Show this message and exit'
  'test' 'Test the ansible playbooks without altering the system'
)

typeset -A CMD=(
  'main' ''
  'install' 'install'
  'packages' 'packages'
  'password' 'password'
  'uninstall' 'uninstall'
  'update' 'update'
)

typeset -A CMD_DESC=(
  'main' "Manage $PROGRAM_NAME on this system"
  'install' "Install $PROGRAM_NAME"
  'packages' "Manage $PROGRAM_NAME packages on this system"
  'password' "Set/validate the $PROGRAM_NAME vault password"
  'uninstall' "Uninstall $PROGRAM_NAME"
  'update' "Update $PROGRAM_NAME"
)

typeset -A CMD_SUBCMD=(
  'main' "$CMD[install]::$CMD_DESC[install]::$CMD[password]::$CMD_DESC[password]::$CMD[uninstall]::$CMD_DESC[uninstall]::$CMD[update]::$CMD_DESC[update]"
  'install' ''
  'packages' ''
  'password' ''
  'uninstall' ''
  'update' ''
)

typeset -A CMD_OPTS=(
  'main' "$OPT[help]::$OPT_DESC[help]"
  'install' "$OPT[help]::$OPT_DESC[help]::$OPT[test]::$OPT_DESC[test]"
  'packages' "$OPT[help]::$OPT_DESC[help]::$OPT[test]::$OPT_DESC[test]"
  'password' "$OPT[help]::$OPT_DESC[help]"
  'uninstall' "$OPT[help]::$OPT_DESC[help]::$OPT[test]::$OPT_DESC[test]"
  'update' "$OPT[help]::$OPT_DESC[help]::$OPT[test]::$OPT_DESC[test]"
)

typeset -A CMD_MSG_END=(
  'install' "$PROGRAM_NAME installed"
  'packages' "$PROGRAM_NAME packages installed/updated"
  'password' "$PROGRAM_NAME vault password validated"
  'uninstall' "$PROGRAM_NAME uninstalled"
  'update' "$PROGRAM_NAME updated"
)

typeset -A CMD_MSG_FAIL=(
  'install' "$PROGRAM_NAME installation failed"
  'packages' "$PROGRAM_NAME packages install/update failed"
  'password' "$PROGRAM_NAME vault password validation failed"
  'uninstall' "$PROGRAM_NAME uninstall failed"
  'update' "$PROGRAM_NAME update failed"
)

typeset -A CMD_MSG_START=(
  'install' "Installing $PROGRAM_NAME"
  'packages' "Installing/updating $PROGRAM_NAME packages"
  'password' "Checking $PROGRAM_NAME vault password"
  'uninstall' "Uninstalling $PROGRAM_NAME"
  'update' "Updating $PROGRAM_NAME"
)

###########
# Ansible #
###########

unset ANSIBLE_LOCAL_TEMP
unset ANSIBLE_REMOTE_TEMP
unset ANSIBLE_SQUASH_ACTIONS
unset ANSIBLE_SSH_CONTROL_PATH
unset ANSIBLE_SSH_CONTROL_PATH_DIR

export ANSIBLE_DISPLAY_SKIPPED_HOSTS=0
export ANSIBLE_FORCE_COLOR=1
export ANSIBLE_RETRY_FILES_ENABLED=0
export ANSIBLE_SSH_PIPELINING=1
export ANSIBLE_VAULT_PASSWORD_FILE="$REPOSITORY_PATH/.ansible-vault"

# A mapping of command names to ansible playbooks. Multiple playbooks are separated by "::".
# When multiple playbooks are specified they are run in the order listed.
typeset -A PLAYBOOKS=(
  $CMD[install] 'uninstall_legacy.yml::package_manager.yml::install.yml'
  $CMD[packages] 'package_manager.yml'
  $CMD[uninstall] 'uninstall.yml'
  $CMD[update] 'package_manager.yml::install.yml'
)

##########
# Output #
##########

typeset -A STYLES=(
  'reset' $(tput sgr0)
  'bold' $(tput bold)
  'standout' $(tput smso)
  'black' $(tput setaf 0)
  'red' $(tput setaf 1)
  'green' $(tput setaf 2)
  'yellow' $(tput setaf 3)
  'blue' $(tput setaf 4)
  'magenta' $(tput setaf 5)
  'cyan' $(tput setaf 6)
  'white' $(tput setaf 7)
)

# Print a stylized message prefixed with "Error: ".
#
# $1 - The message to print. Default is "Undefined".
function error() {
  print >&2
  print "$STYLES[red]$STYLES[bold]Error:$STYLES[reset] ${1:-"Undefined"}" >&2
}

# Print a stylized unprefixed message.
#
# $1 - The message to print. Default is "Undefined".
function info() {
  print >&2
  print "$STYLES[blue]$STYLES[bold]${1:-"Undefined"}$STYLES[reset]" >&2
}

# Print a stylized message prefixed with "OK: ".
#
# $1 - The message to print. Default is "Undefined".
function ok() {
  print "$STYLES[green]$STYLES[bold]OK:$STYLES[reset] ${1:-"Undefined"}" >&2
}

# Print a stylized message prefixed with "Warning: ".
#
# $1 - The message to print. Default is "Undefined".
function warn() {
  print >&2
  print "$STYLES[yellow]$STYLES[bold]Warning:$STYLES[reset] ${1:-"Undefined"}" >&2
}

# Print the command help and exit.
#
# $1 - The command name.
function showHelp() {
  validateArgCount "$0" $# 1 1
  local name="$1"
  local usage=(
    "$STYLES[blue]$STYLES[bold]Usage:$STYLES[reset] $PROGRAM_NAME"
    "${CMD[$name]:+"$STYLES[green]$STYLES[bold]$CMD[$name]$STYLES[reset]"}"
    "${CMD_OPTS[$name]:+"$STYLES[cyan]$STYLES[bold][OPTIONS]$STYLES[reset]"}"
    "${CMD_SUBCMD[$name]:+"$STYLES[red]$STYLES[bold]COMMAND$STYLES[reset]"}"
    "${CMD_SUBCMD[$name]:+"$STYLES[yellow]$STYLES[bold][ARGS...]$STYLES[reset]"}"
  )

  print "$usage" | tr -s ' '  # collapse double-spaces for empty items
  print
  print "  $CMD_DESC[$name]"

  if [[ ! -z $CMD_OPTS[$name] ]]
  then
    print
    print "$STYLES[cyan]$STYLES[bold]Options:$STYLES[reset]"
    print -aC 2 -- ${(@s/::/)CMD_OPTS[$name]} | sed 's/^/  /'
  fi

  if [[ ! -z $CMD_SUBCMD[$name] ]]
  then
    print
    print "$STYLES[red]$STYLES[bold]Commands:$STYLES[reset]"
    print -aC 2 -- ${(@s/::/)CMD_SUBCMD[$name]} | sed 's/^/  /'
  fi

  quit
}

##########################
# Flow Control Functions #
##########################

# Stop execution with a relevant error message.
#
# $1 - The message to print. Default is "Undefined".
function die() {
  error "${1:-"Undefined"}"
  exit 1
}

# Stop execution with the given exit code and optional message.
#
# $1 - The exit code. Optional. Default is 0.
# $2 - A message to print. Optional.
function quit() {
  validateArgCount "$0" $# 0 2
  local code="${1:-0}" message="${2:-""}"

  [[ ! -z $message ]] && print "\n$message" >&2
  exit "$code"
}

#####################
# Utility Functions #
#####################

# Validate argument count.
#
# $1 - The calling command or function name.
# $2 - The number of arguments received.
# $3 - The minimum number of arguments required, inclusive. Set to -1 for no limit. Default is -1.
# $4 - The maximum number of arguments required, inclusive. Set to -1 for no limit. Default is -1.
function validateArgCount() {
  local caller="$1" count=$2 min=${3:-'-1'} max=${4:-'-1'}

  (( min >= 0 && count < min )) && die "($caller) Too few arguments"
  (( max >= 0 && count > max )) && die "($caller) Too many arguments"
}

###########
# Program #
###########

# Run the program.
#
# $1 - The command or option flag.
# $2 - When $1 is a command name, an option flag for the command. Optional.
function main() {
  [[ ${$(uname):l} != 'darwin' ]] && die "$PROGRAM_NAME requires macOS"
  [[ ${EUID:-${UID}} == '0' ]] && die "$PROGRAM_NAME can not be run as root"

  validateArgCount "$0" $# 1 2

  local name='main'

  cd "$REPOSITORY_PATH"

  case $1 in
    -h|--help)                  showHelp "$name";;
    password)                   shift; checkVaultPassword "$@";;
    install|packages|uninstall) name="$1"; shift; runPlaybooks "$name" "$@";;
    update)                     name="$1"; shift; updateRepo; runPlaybooks "$name" "$@";;
    -*)                         die "Unknown option $1";;
    *)                          die "Unknown command $1";;
  esac

  quit
}

# Set and validate the ansible vault password.
#
# $1 - The command option flag (optional).
function checkVaultPassword() {
  validateArgCount "$0" $# 0 1
  local name='password' vaultPassword

  case $1 in
    -h|--help)  showHelp "$name";;
    '')         ;;
    -*)         die "Unknown option $1";;
    *)          die "Unknown argument $1";;
  esac

  info "$CMD_MSG_START[$name]"

  if ! [[ -f $ANSIBLE_VAULT_PASSWORD_FILE ]]
  then
    while true
    do
      print >&2
      read -s "vaultPassword?$STYLES[magenta]$STYLES[bold]Enter vault password:$STYLES[reset] "
      [[ $vaultPassword != $'\n' && $vaultPassword != $'\r' ]] && print >&2
      [[ $vaultPassword == *[![:space:]]* ]] && break

      warn 'Vault password cannot be blank'
    done

    print "$vaultPassword" > "$ANSIBLE_VAULT_PASSWORD_FILE"

  fi

  if ! ansible-vault decrypt --output - tests/vaultTest.yml &>/dev/null
  then
    rm "$ANSIBLE_VAULT_PASSWORD_FILE" &>/dev/null
    die "$CMD_MSG_FAIL[$name]"
  fi

  ok "$CMD_MSG_END[$name]"
}

# Run the ansible playbooks for the designated command.
#
# $1 - The command name.
# $2 - The command option flag (optional).
function runPlaybooks() {
  validateArgCount "$0" $# 1 2
  local name="$1" check=''

  case $2 in
    -h|--help)  showHelp "$name";;
    -t|--test)  check='--check';;
    '')         ;;
    -*)         die "Unknown option $2";;
    *)          die "Unknown argument $2";;
  esac

  checkVaultPassword

  info "$CMD_MSG_START[$name]"

  for playbook in ${(@s/::/)PLAYBOOKS[$name]}
  do
    if ! ansible-playbook --limit "$(hostname)" $check "$playbook"
    then
      die "$CMD_MSG_FAIL[$name]"
    fi
  done

  ok "$CMD_MSG_END[$name]"
  quit
}

# Update the local dotfiles repository.
function updateRepo() {
  validateArgCount "$0" 0 0
  local repositoryChanges=0

  info "Updating $PROGRAM_NAME repository"

  if ! git fetch &>/dev/null
  then
    die "$PROGRAM_NAME remote repository fetch failed"
  fi

  repositoryChanges=$(git rev-list main...origin/main --count) &>/dev/null

  if [[ -z $repositoryChanges ]]
  then
    die "$PROGRAM_NAME repository state comparison failed"
  fi

  if (( $repositoryChanges == 0 ))
  then
    ok "$PROGRAM_NAME is up to date"
  fi

  if ! git pull &>/dev/null
  then
    die "$PROGRAM_NAME remote repository pull failed"
  fi

  ok "$PROGRAM_NAME repository updated"
}

main "$@"
