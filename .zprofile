echo "sourcing ~/.zprofile"

# NOTE: homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# NOTE: only start hyprland on arch
# start hyprland before sourcing .zshrc otherwise it won't start
if [[ -f "/etc/os-release" ]] && [[ $(cat "/etc/os-release" | grep "^ID=" | sed 's/^ID=//') == "arch" ]]; then
  if uwsm check may-start; then
    exec uwsm start hyprland.desktop
  fi
fi

if [[ -f ~/.zshrc ]]; then
  echo "sourcing ~/.zshrc"
  source ~/.zshrc
fi
