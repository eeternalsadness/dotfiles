source "$HOME/.shell_envs"
source "$HOME/.shell_aliases"

# config history & vi mode
SAVEHIST=2000
setopt vi extended_glob hist_ignore_dups inc_append_history no_extended_history share_history
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

# kubectl installed inside devbox
if [[ -n "$DEVBOX_SHELL_ENABLED" ]]; then
  source <(kubectl completion zsh)
fi

# zsh extras
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# use devbox shell
$SCRIPTS/devbox/start-devbox-shell.sh
