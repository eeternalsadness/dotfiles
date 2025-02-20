if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi

if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi
