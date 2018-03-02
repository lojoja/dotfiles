# dotfiles/bash/manpath.sh

MANPATH="/usr/share/man"
MANPATH="/usr/local/share/man:$MANPATH"
MANPATH="/usr/local/opt/sqlite/share/man:$MANPATH"
MANPATH="/usr/local/opt/python/share/man:$MANPATH"
MANPATH="/usr/local/opt/python@2/share/man:$MANPATH"
MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export MANPATH="$MANPATH"
