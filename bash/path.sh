# dotfiles/bash/path.sh

PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/opt/sqlite/bin:$PATH"
PATH="/usr/local/opt/ruby/bin:$PATH"
PATH="/usr/local/opt/gnu-which/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-units/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-time/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

SUBL_BASE_PATH="$(find /Applications -maxdepth 1 -type d -name 'Sublime Text*.app')"

if [[ -d $SUBL_BASE_PATH ]]
then
  PATH="$SUBL_BASE_PATH/Contents/SharedSupport/bin:$PATH"
fi

unset SUBL_BASE_PATH

PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
PATH="$HOME/.gem/ruby/3.3.0/bin:$PATH"
PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$PATH"
