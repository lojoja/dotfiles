# dotfiles/bash/program/java.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  if hash /usr/libexec/java_home &>/dev/null
  then
    JAVA_HOME="$(/usr/libexec/java_home)"
    export JAVA_HOME="$JAVA_HOME"
  fi
fi
