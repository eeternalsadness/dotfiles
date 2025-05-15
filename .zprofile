echo "sourcing ~/.zprofile"

# NOTE: homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [[ -f ~/.zshrc ]]; then
  echo "sourcing ~/.zshrc"
  source ~/.zshrc
fi

# NOTE: only start hyprland on arch
if [[ -f "/etc/os-release" ]] && [[ $(cat "/etc/os-release" | grep "^ID=" | sed 's/^ID=//') == "arch" ]]; then
  if uwsm check may-start; then
    exec uwsm start hyprland.desktop
  fi
fi
