# dotfiles/bash/shell.sh

shopt -s nocaseglob
shopt -s cdspell
shopt -s checkwinsize

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  export SHELL_SESSION_HISTORY=0
  export BASH_SILENCE_DEPRECATION_WARNING=1
fi

export HISTCONTROL='ignoredups:erasedups'
export HISTTIMEFORMAT='[%F %T] '
export HISTSIZE=999999
export HISTFILESIZE=$HISTSIZE;
export HISTIGNORE='..:...:....:--:cd:cd..:ls:lsa:lsd:ll:lla:lld:pwd:exit:date:history'

shopt -s histappend
shopt -s histreedit
shopt -s histverify

# Bash4
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;

completions='/etc/bash_completion'

if [[ $DOTFILES_INIT_HOMEBREW_PREFIX != "" ]]
then
  completions="$DOTFILES_INIT_HOMEBREW_PREFIX/$completions"
fi

if [[ -r $completions ]]
then
  source "$completions"
fi

unset completions
