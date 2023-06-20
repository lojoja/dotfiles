#!/usr/bin/env zsh
#
# An interface for running ansible playbooks to manage a dotfiles installation.

PROGRAM_NAME=dotfiles
REPOSITORY=https://github.com/lojoja/dotfiles
REPOSITORY_PATH="${0:A:h:h}"
LEGACY_REPOSITORY_PATH="$HOME/.dotfiles"

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
# $1 - The active command name, if different than the root command name.
# $2 - The active command description.
# $3 - The command options as a 'name::description' delimited string. Optional.
# $4 - The command subcommands as a 'name::description' delimited string. Optional.
function showHelp() {
  validateArgCount "$0" $# 2 4
  local command="${1:-""}"
  local description="$2"
  local options="${3:-""}"
  local commands="${4:-""}"
  local usage=(
    "$STYLES[blue]$STYLES[bold]Usage:$STYLES[reset] $PROGRAM_NAME"
    "${command:+"$STYLES[green]$STYLES[bold]$command$STYLES[reset]"}"
    "${options:+"$STYLES[cyan]$STYLES[bold][OPTIONS]$STYLES[reset]"}"
    "${commands:+"$STYLES[red]$STYLES[bold]COMMAND$STYLES[reset]"}"
    "${commands:+"$STYLES[yellow]$STYLES[bold][ARGS...]$STYLES[reset]"}"
  )

  print "$usage" | tr -s ' '  # collapse double-spaces for empty items
  print
  print "  $description"

  if [[ ! -z $options ]]
  then
    print
    print "$STYLES[cyan]$STYLES[bold]Options:$STYLES[reset]"
    print -aC 2 -- ${(@s/::/)options} | sed 's/^/  /'
  fi

  if [[ ! -z $commands ]]
  then
    print
    print "$STYLES[red]$STYLES[bold]Commands:$STYLES[reset]"
    print -aC 2 -- ${(@s/::/)commands} | sed 's/^/  /'
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

# Format item pairs as a '::' delimited string.
#
# $1..n - Alternating key and value pairs (e.g., `joined=$(joinItems 'foo' 'foo val' 'bar' 'bar val')`).
function joinItems() {
  validateArgCountEven "$0" $# 2
  print -n -- ${(j/::/)@}
}

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

# Validate argument count and assert the count is even.
#
# $1 - The calling command or function name.
# $2 - The number of arguments received.
# $3 - The minimum number of arguments required, inclusive. Set to -1 for no limit.
# $4 - The maximum number of arguments required, inclusive. Set to -1 for no limit.
function validateArgCountEven() {
  validateArgCount "$@"
  local caller="$1" count=$2

  (( count%2 == 0 )) || die "($caller) Expected an even number of arguments"
}

############
# Commands #
############

OPT_DEBUG_FLAG='-d, --debug'
OPT_DEBUG_DESC='Target a tmp directory for debugging'

OPT_HELP_FLAG='-h, --help'
OPT_HELP_DESC='Show this message and exit'

CMD_INSTALL_NAME='install'
CMD_INSTALL_DESC="Install $PROGRAM_NAME"
CMD_INSTALL_OPTS="$(joinItems "$OPT_DEBUG_FLAG" "$OPT_DEBUG_DESC" "$OPT_HELP_FLAG" "$OPT_HELP_DESC")"

CMD_UNINSTALL_NAME='uninstall'
CMD_UNINSTALL_DESC="Uninstall $PROGRAM_NAME"
CMD_UNINSTALL_OPTS="$(joinItems "$OPT_DEBUG_FLAG" "$OPT_DEBUG_DESC" "$OPT_HELP_FLAG" "$OPT_HELP_DESC")"

CMD_UPDATE_NAME='update'
CMD_UPDATE_DESC='Check for and install available updates'
CMD_UPDATE_OPTS="$(joinItems "$OPT_HELP_FLAG" "$OPT_HELP_DESC")"

CMD_MAIN_NAME=''
CMD_MAIN_DESC="Manage lojoja's dotfiles on this system"
CMD_MAIN_CMDS="$(joinItems \
  "$CMD_INSTALL_NAME" "$CMD_INSTALL_DESC" \
  "$CMD_UNINSTALL_NAME" "$CMD_UNINSTALL_DESC" \
  "$CMD_UPDATE_NAME" "$CMD_UPDATE_DESC" \
)"
CMD_MAIN_OPTS="$(joinItems "$OPT_HELP_FLAG" "$OPT_HELP_DESC")"


function main() {
  [[ ${$(uname):l} != 'darwin' ]] && die "$PROGRAM_NAME requires macOS"
  [[ ${EUID:-${UID}} == '0' ]] && die "$PROGRAM_NAME can not be run as root"

  validateArgCount "$0" $# 1 -1

  case $1 in
    -h|--help)  showHelp "$CMD_MAIN_NAME" "$CMD_MAIN_DESC" "$CMD_MAIN_OPTS" "$CMD_MAIN_CMDS";;
    install)    install "${@:2}";;
    uninstall)  uninstall "${@:2}";;
    update)     update "${@:2}";;
    -*)         die "Unknown option $1";;
    *)          die "Unknown command $1";;
  esac

  quit
}

function install() {
  validateArgCount "$0" $# 0 1
  local debug

  case $1 in
    -h|--help)  showHelp "$CMD_INSTALL_NAME" "$CMD_INSTALL_DESC" "$CMD_INSTALL_OPTS";;
    -d|--debug) debug=1;;
    "")         debug=0;;
    -*)         die "Unknown option $1";;
    *)          die "Unknown command $1";;
  esac

  info 'Installing dotfiles'
  quit
}

function uninstall() {
  validateArgCount "$0" $# 0 1
  local debug

  case $1 in
    -h|--help)  showHelp "$CMD_UNINSTALL_NAME" "$CMD_UNINSTALL_DESC" "$CMD_UNINSTALL_OPTS";;
    -d|--debug) debug=1;;
    "")         debug=0;;
    -*)         die "Unknown option $1";;
    *)          die "Unknown command $1";;
  esac

  info 'Uninstalling dotfiles'
  quit
}

function update() {
  validateArgCount "$0" $# 0 1
  local debug

  case $1 in
    -h|--help)  showHelp "$CMD_UPDATE_NAME" "$CMD_UPDATE_DESC" "$CMD_UPDATE_OPTS";;
    -d|--debug) debug=1;;
    "")         debug=0;;
    -*)         die "Unknown option $1";;
    *)          die "Unknown command $1";;
  esac

  info 'Updating dotfiles'
  quit
}

main "$@"
