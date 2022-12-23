# dotfiles/shared/shell/custom/java.sh
# shellcheck shell=bash

if hash /usr/libexec/java_home &>/dev/null
then
  JAVA_HOME="$(/usr/libexec/java_home)"
  export JAVA_HOME
fi
