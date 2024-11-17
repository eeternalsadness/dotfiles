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
if [ -x /usr/bin/dircolors ]; then
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
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# enable vim mode
set -o vi

# envs
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export OBSIDIAN="$HOME/Obsidian"
export OBSIDIAN_INBOX="$HOME/Obsidian/0-inbox"
export SCRIPTS="$HOME/scripts"
export REPO="$HOME/Repo"
export LANG="en_US.UTF-8"

# git aliases
alias gco='git checkout $(git branch -a | grep -v "HEAD ->" | tr -d "[\t\ ]" | sed "s/^\*//;s/^remotes\/origin\///" | sort | uniq | fzf)'
alias gbd='git branch -D $(git branch | grep -v "HEAD ->" | tr -d "[\t\ ]" | sed "s/^\*//" | fzf --multi)'
alias gfp='git fetch && git pull'

# ws aliases
alias wsinit='docker run --privileged -dit \
    --name workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $REPO:/root/Repo \
    -v $OBSIDIAN:/root/Obsidian \
    caudit123/workspace:latest'
alias wsrun='docker start workspace; docker exec -it workspace bash'
alias wstest='docker run --privileged -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $REPO:/root/Repo \
    -v $OBSIDIAN:/root/Obsidian \
    caudit123/workspace:latest'
alias wsupdate='docker pull caudit123/workspace:latest && docker image prune -f'
alias wsrm='docker stop workspace; docker rm workspace'

# obsidian aliases
alias zet='bash $SCRIPTS/obsidian/zet-new-file.sh'
alias day='bash $SCRIPTS/obsidian/daily-note.sh'
alias week='bash $SCRIPTS/obsidian/weekly-note.sh'
alias month='bash $SCRIPTS/obsidian/monthly-note.sh'
alias year='bash $SCRIPTS/obsidian/yearly-note.sh'

# bash aliases
alias bashconfig='nvim ~/.bashrc && source ~/.bashrc'

# gitlab
export GITLAB_TOKEN=''
export GITLAB_HOST='gitlab.com'

alias glpid='bash $SCRIPTS/gitlab/get-project-id.sh'
alias gluid='bash $SCRIPTS/gitlab/get-user-id.sh'
