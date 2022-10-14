# dotfiles/zsh/custom/java.zsh
# shellcheck shell=zsh

if hash /usr/libexec/java_home &>/dev/null
then
  JAVA_HOME="$(/usr/libexec/java_home)"
  export JAVA_HOME
fi
