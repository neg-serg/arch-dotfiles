```
    ░█▀█░█▀▀░█▀▀░░░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀
    ░█░█░█▀▀░█░█░░░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█
    ░▀░▀░▀▀▀░▀▀▀░░░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀
```

Of course this dotfiles structure not include everything that I use, like QEMU.

# Screenshots

![terminal_shot](https://i.imgur.com/O08SzU3.png)
![nvim_shot](https://i.imgur.com/Tqfu65R.png)
![firefox_shot](https://i.imgur.com/rgq2LcN.png)
![unixporn_like_shot](https://i.imgur.com/z1arTLh.png)

+ Terminal
    + **alacritty** -- nice cross-platform terminal emulator, but I am using suckless
    terminal for now.
    + **sh** -- based bourne shell config.
    + **bash** -- I don't use bash widely, anyway I have some basic config.
    + **zsh** -- the best of the best shell for me, pretty complex custom config. Based on GRML many years ago, maybe now it is not.
    + **cool-retro-term** -- very nice(but slow) terminal emulator a-la "old TV"
    + **term-colorschemes** -- various dynamic colorschemes, not up-to-date.
    + **terminfo** -- terminfo...
    + **dircolors** -- my 256-color filetype-based dircolors.
    + **@tmux** -- tmux config
+ Dev
    + **vim** -- I am using neovim for now, a lot of nice stuff. Also used as IDE for almost all languages(except of java, scala)
    + **dcvs** -- configs for dcvs, except git.
    + **ghc** -- nice prompt for GHC(haskell compiler) and another basic stuff.
    + **git** -- config for git(.gitconfig)
+ Debugging
    + **gdb** -- debugger.
    + **cgdb** -- better gdb tui. Probably not better then gdb-dashboard, but it's useful anyway.
+ Music
    + **mpd** -- music player daemon and mpd-notification configs.
    + **ncmpcpp** -- mpd client
    + **beets** -- music library manager
+ Window system / X11
    + **i3** -- my current WM with a lot of new stuff. I migrated to it after many years of using my fork of Notion WM.
    + **gtk** -- gtkrc
    + **dunst** -- my minimalistic notification daemon, which also used for mpd-notification.
    + **polybar** -- my statusbar
    + **keymaps** -- alternative keymaps. I am using xmodmaprc with caps-lock rebinded to ctrl, etc.
    + **x11** -- xinitrc, Xresources, xserverrc
    + **xinit** -- scripts for .xinitrc to run compositing, custom keybindings, etc.
    + **xres** -- include files for .Xresources.
    + **wl** -- wallpaper list stuff.
    + **rofi** -- dmenu analogue to run programs, find windows, everything, used very widely.
    + **sxhkd** -- x11-wide keybindings, independent to WM.
    + **color_profiles** -- custom icm color-profiles, I don't use it a lot, but it's funny.
    + **compton** -- my x11 compositing manager.
+ Net
    + **tridactyl** -- Vimperator-like firefox addon. Vim-like keybindings and UX in firefox.
    + **stig** -- custom colorscheme for this nice transmission-client
+ IM / Mail / News
    + **mutt** -- famous cli-based mail-client
    + **newsboat** -- cli newsbeuter-based rss-reader.
+ Media
    + **mpv** -- my minimalistic video player config.
    + **sxiv** -- config for my fork of sxiv, image viewer.
+ Emulators
    + **dos** -- configs for dos emulators.
+ systemd
    + **systemd** -- user services(for `systemctl --user`)
        + caddy.service: local webserver for firefox startpage
        + caffeine.service: Prevents the desktop becoming idle in full-screen mode
        + downloads.service: Downloads cleaner and handler
        + compton.service: Compositing manager
        + cursor_swarp.service: cursor swarp
        + downloads.service: Downloads cleaner and handler
        + dunst.service: Lightweight and customizable notification daemon
        + gnome-keyring-daemon.service: Gnome keyring daemon
        + gpaste.service: GPaste clipboard manager daemon
        + mpd.service: Music Player Daemon
        + mpdas.service: mpdas last.fm scrobbler
        + mpd-notification.service: MPD Notification
        + nm-applet.service: Network manager applet
        + sxhkd.service: fast hotkey manager
        + transmissiond.service: transmission service
        + udiskie.service: automounter
        + update-pic-dirs.service: Pic dirs notification
        + wallpaper.service: setup wallpaper on startup
        + x11.service: startx as service
        + xinput_settings.service: my xinput settings
+ Doc
    + **zathura** -- nice and tiny pdf/djvu/whatever viewer with UX similar to vim
+ Misc
    + **neofetch** -- nice fetch with custom config
    + **npm** -- nothing.
    + **htop** -- basic htop stuff(monochromatic for now)
    + **imgur, imgur-screenshot** -- imgur uploaders.
    + **misc** -- various stuff, which I don't use a lot as like urlview, keynav, etc.
    + **task** -- basic config for my GTD-like tool taskwarrior.
    + **ranger** -- nice console-based filemanager. I do not using it a lot, but like picture preview feature(in terminal, based on w3m).
