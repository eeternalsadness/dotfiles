# source envs, aliases, and common configs
source "$HOME/.shell_envs"
source "$HOME/.shell_aliases"
source "$HOME/.shell_common"

# config history
SAVEHIST=2000
setopt extended_glob hist_ignore_dups inc_append_history no_extended_history share_history
bindkey '^R' history-incremental-search-backward

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

# kubectl installed inside devbox
if [[ -n "$DEVBOX_SHELL_ENABLED" ]]; then
  source <(kubectl completion zsh)
fi

# zsh extras
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# use devbox shell
$SCRIPTS/devbox/start-devbox-shell.sh
