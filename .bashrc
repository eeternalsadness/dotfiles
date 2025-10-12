# source envs, aliases, and common configs
source "$HOME/.shell_envs"
source "$HOME/.shell_aliases"
source "$HOME/.shell_common"

# config history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# shopt
shopt -s histappend checkwinsize globstar
set -o vi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# use color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -G' # Change to -G for macOS
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
elif [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [[ $(uname) == "Darwin" ]]; then
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
elif ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . "/usr/share/bash-completion/bash_completion"
  elif [ -f /etc/bash_completion ]; then
    . "/etc/bash_completion"
  fi
fi

# ssh completion
if [[ -f "$SCRIPTS/completion/ssh-completion.sh" ]]; then
  source "$SCRIPTS/completion/ssh-completion.sh"
fi

# use devbox shell
"$SCRIPTS"/devbox/start-devbox-shell.sh
