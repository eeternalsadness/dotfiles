# NOTE: only start hyprland on arch
if [[ -f "etc/os-release" ]] && [[ $(cat "/etc/os-release" | grep "^ID=" | sed 's/^ID=//') == "arch" ]]; then
  if uwsm check may-start; then
    exec uwsm start hyprland.desktop
  fi
fi

if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi
