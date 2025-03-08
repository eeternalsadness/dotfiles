# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# shopt
shopt -s checkwinsize
shopt -s globstar

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
if [[ $(uname) == "Darwin" ]]; then
  # The notify-send command doesn't exist on macOS, use osascript instead.
  alias alert='osascript -e "display notification \"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'' )\" with title \"Alert\""'
else
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
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

# enable vim mode
set -o vi

# increase file descriptor limit
ulimit -n 1024

# asusctl stuff
if [[ -n $(which asusctl) ]] && [[ -n $(which supergfxctl) ]]; then
  alias kb='bash $SCRIPTS/asusctl/toggle-keyboard-backlight.sh'
  alias pow='bash $SCRIPTS/asusctl/switch-power-profile.sh'
fi

# git aliases
alias gco='git checkout $(git branch -a | grep -v "HEAD ->" | tr -d "[\t\ ]" | sed "s/^\*//;s/^remotes\/origin\///" | sort | uniq | fzf)'
alias gbd='git branch -D $(git branch | grep -v "HEAD ->" | tr -d "[\t\ ]" | sed "s/^\*//" | fzf --multi)'
alias gfp='git fetch --prune && git pull'

# terraform
alias tf='terraform'
alias tfv='bash $SCRIPTS/terraform/tf-get-provider-latest-version.sh'

# obsidian aliases
alias zet='bash $SCRIPTS/obsidian/zet-new-file.sh'
alias day='bash $SCRIPTS/obsidian/daily-note.sh'
alias week='bash $SCRIPTS/obsidian/weekly-note.sh'
alias month='bash $SCRIPTS/obsidian/monthly-note.sh'
alias year='bash $SCRIPTS/obsidian/yearly-note.sh'
alias zipnotes='bash $SCRIPTS/obsidian/zip-notes.sh'

# bash aliases
alias bashconfig='nvim ~/.bashrc && source ~/.bashrc'

# gitlab
alias glpid='$SCRIPTS/gitlab/get-project-id.sh'
alias gluid='$SCRIPTS/gitlab/get-user-id.sh'

# ssh aliases
alias sshgenconfig='bash $SCRIPTS/ssh/generate-ssh-config-from-rdm-export.sh'
alias sshenv='bash $SCRIPTS/ssh/switch-env.sh'

# tmux aliases
alias tconfig='nvim ~/.tmux.conf && tmux source ~/.tmux.conf'
alias ti='bash $SCRIPTS/tmux/start-tmux.sh'
alias tk='tmux kill-server'

# pass aliases
alias p='pass show -c'

# VPN
alias vpnon='sudo systemctl start openvpn-client@client.service'
alias vpnoff='sudo systemctl stop openvpn-client@client.service'
alias vpnstatus='systemctl status openvpn-client@client.service'

# kubernetes
alias k='kubectl'

# python venv
alias venv='source ~/.venv/bin/activate'

# ssh completion
if [[ -f "$SCRIPTS/completion/ssh-completion.sh" ]]; then
  source $SCRIPTS/completion/ssh-completion.sh
fi

# use devbox shell
if [[ -z "$DEVBOX_SHELL_ENABLED" ]]; then
  devbox shell
fi
