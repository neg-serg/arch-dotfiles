if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
  export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
  export XDG_CURRENT_DESKTOP=GNOME
  export XINITRC="$HOME/.config/xinit/xinitrc"
  export XSERVERRC="$HOME/.config/xinit/xserverrc"
  ~/bin/scripts/xinit
fi
