if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  XINITRC="$HOME/.config/xinit/xinitrc" XSERVERRC="$HOME/.config/xinit/xserverrc" ~/bin/scripts/xinit
fi
