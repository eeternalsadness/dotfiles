# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# setopt
setopt extended_glob

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable vim mode
set -o vi

# increase file descriptor limit
ulimit -n 1024

# pure prompt
PURE_GIT_PULL=0

fpath+=("$(brew --prefix)/share/zsh/site-functions")

autoload -U promptinit; promptinit
prompt pure

# completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# git aliases
alias gco='git checkout $(git branch -a | grep -v "HEAD ->" | tr -d "[\t\ ]" | sed "s/^\*//;s/^remotes\/origin\///" | sort | uniq | fzf)'
alias gbd='git branch -D $(git branch | grep -v "HEAD ->" | tr -d "[\t\ ]" | sed "s/^\*//" | fzf --multi)'
alias gfp='git fetch --prune && git pull'

# terraform
alias tf='terraform'
alias tfv='$SCRIPTS/terraform/tf-get-provider-latest-version.sh'
alias tff='terraform fmt -recursive && terraform validate'

# obsidian aliases
alias zet='$SCRIPTS/obsidian/zet-new-file.sh'
alias day='$SCRIPTS/obsidian/daily-note.sh'
alias week='$SCRIPTS/obsidian/weekly-note.sh'
alias month='$SCRIPTS/obsidian/monthly-note.sh'
alias year='$SCRIPTS/obsidian/yearly-note.sh'
alias zipnotes='$SCRIPTS/obsidian/zip-notes.sh'

# bash aliases
alias zshconfig='nvim ~/.zshrc && source ~/.zshrc'

# gitlab
alias glpid='$SCRIPTS/gitlab/get-project-id.sh'
alias gluid='$SCRIPTS/gitlab/get-user-id.sh'

# ssh aliases
alias sshgenconfig='$SCRIPTS/ssh/generate-ssh-config-from-rdm-export.sh'
alias sshenv='$SCRIPTS/ssh/switch-env.sh'

# tmux aliases
alias tconfig='nvim ~/.tmux.conf && tmux source ~/.tmux.conf'
alias ti='$SCRIPTS/tmux/start-tmux.sh'
alias tk='tmux kill-server'

# pass aliases
alias p='pass show -c'

# VPN
alias vpnon='sudo launchctl start com.openvpn.client.plist'
alias vpnoff='sudo launchctl stop com.openvpn.client.plist'
alias vpnstatus='sudo launchctl list | grep openvpn'

# kubernetes
alias k='kubectl'

source <(kubectl completion zsh)

# vault
alias vlvault='export VAULT_TOKEN=$(vault login -method=oidc role="terraform-vault" -format=json | jq -r .auth.client_token)'

# python venv
activate_venv ()
{
  root_dir="${1:-$HOME}"
  source "${root_dir}/.venv/bin/activate"
}
alias venv='activate_venv'

# claude desktop
alias claudeconfig='nvim ~/Library/Application\ Support/Claude/claude_desktop_config.json'

# use devbox shell
if [[ -z "$DEVBOX_SHELL_ENABLED" ]]; then
  devbox shell
fi

# zsh extras
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
