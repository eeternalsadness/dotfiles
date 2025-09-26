SAVEHIST=2000

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable vim mode
set -o vi
bindkey '^R' history-incremental-search-backward

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

# setopt
setopt extended_glob hist_ignore_dups inc_append_history no_extended_history share_history

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

# zsh aliases
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

# nvim aliases
alias vim='nvim'
alias vi='nvim'

# asusctl stuff
if [[ -n $(which asusctl) ]] && [[ -n $(which supergfxctl) ]]; then
  alias kb='$SCRIPTS/asusctl/toggle-keyboard-backlight.sh'
  alias pow='$SCRIPTS/asusctl/switch-power-profile.sh'
fi

# kubernetes
alias k='kubectl'
alias kns='kubens'
alias ktx='kubectx'

# kubectl installed inside devbox
if [[ -n "$DEVBOX_SHELL_ENABLED" ]]; then
  source <(kubectl completion zsh)
fi

# vault
vault_login() {
  local role="$1"
  local mount_path="${2:-oidc-google}"

  export VAULT_TOKEN=$(vault login -method=oidc -path="$mount_path" role="$role" -format=json | jq -r .auth.client_token)
}
alias vl='vault_login'

# grafana
alias grafanaauth='export GRAFANA_AUTH="$(vault kv get -mount=kvv2 -field=username grafana/users/admin):$(vault kv get -mount=kvv2 -field=password grafana/users/admin)"'

# consul
consul_get_token() {
  local role="$1"
  export CONSUL_HTTP_TOKEN=$(vault read consul/creds/${role} -format=json | jq -r '.data.token')
}
alias consultoken='consul_get_token'

# VPN
alias vpnnp='sudo openfortivpn -c ~/.config/openfortivpn/dev.conf'
alias vpnp='sudo openfortivpn -c ~/.config/openfortivpn/prod.conf'

# python venv
activate_venv ()
{
  root_dir="${1:-$HOME}"
  source "${root_dir}/.venv/bin/activate"
}
alias venv='activate_venv'

# aws
set_aws_profile() {
  local aws_profile="$1"

  if [ -z "$aws_profile" ]; then
    echo "AWS profile name missing"
  fi

  export AWS_PROFILE="$aws_profile"
}
alias awsenv='set_aws_profile'

# claude desktop
alias claudeconfig='nvim ~/Library/Application\ Support/Claude/claude_desktop_config.json'

# zsh extras
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# use devbox shell
if [[ -z "$DEVBOX_SHELL_ENABLED" ]]; then
  devbox shell
fi
