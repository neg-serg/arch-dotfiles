```
    ░█▀█░█▀▀░█▀▀░░░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀
    ░█░█░█▀▀░█░█░░░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█
    ░▀░▀░▀▀▀░▀▀▀░░░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀
```

Of course this dotfiles structure not include everything that I use, like QEMU.

+ Terminal
    + **alacritty**               **::** nice cross-platform terminal emulator, but I am using suckless
    terminal for now.
    + **sh**                      **::** based bourne shell config.
    + **bash**                    **::** I don't use bash widely, anyway I have some basic config.
    + **zsh**                     **::** the best of the best shell for me, pretty complex custom config. Based on GRML many years ago, maybe now it is not.
    + **cool-retro-term**         **::** very nice(but slow) terminal emulator a-la "old TV"
    + **term-colorschemes**       **::** various dynamic colorschemes, not up-to-date.
    + **terminfo**                **::** terminfo...
    + **dircolors**               **::** my 256-color filetype-based dircolors.
    + **powerline**               **::** famous statusbar, I am using it only with tmux for now, because of no support in neovim.
    + **@tmux**                   **::** tmux config
+ Dev
    + **vim**                     **::** I am using neovim for now, a lot of nice stuff. Also used as IDE for almost all languages(except of java, scala)
    + **dcvs**                    **::** configs for dcvs, except git.
    + **ghc**                     **::** nice prompt for GHC(haskell compiler) and another basic stuff.
    + **git**                     **::** config for git(.gitconfig)
    + **emacs**                   **::** choose from @rogue_emacs, @spacemacs, @doom_emacs.
+ Debugging
    + **gdb**                     **::** debugger.
    + **cgdb**                    **::** better gdb tui. Probably not better then gdb-dashboard, but it's useful anyway.
+ Music
    + **mpd**                     **::** music player daemon and mpd-notification configs.
    + **ncmpcpp**                 **::** mpd client
+ Window system / X11
    + **i3**                      **::** my current WM with a lot of new stuff. I migrated to it after many years of using my fork of Notion WM.
    + **gtk**                     **::** gtkrc
    + **dunst**                   **::** my minimalistic notification daemon, which also used for mpd-notification.
    + **polybar**                 **::** my statusbar
    + **keymaps**                 **::** alternative keymaps. I am using xmodmaprc with caps-lock rebinded to ctrl, etc.
    + **x11**                     **::** .xbindkeysrc.scm  .XCompose  .xinitrc  .Xresources  .xserverrc
    + **xinit**                   **::** scripts for .xinitrc to run compositing, custom keybindings, etc.
    + **xres**                    **::** include files for .Xresources.
    + **xsettingsd**              **::** DE-independent settings daemon, my system have no Gnome, etc.
    + **wl**                      **::** wallpaper list stuff.
    + **rofi**                    **::** dmenu analogue to run programs, find windows, everything, used very widely.
    + **sxhkd**                   **::** x11-wide keybindings, independent to WM.
    + **color_profiles**          **::** custom icm color-profiles, I don't use it a lot, but it's funny.
    + **compton**                 **::** my x11 compositing manager.
    + **weston**                  **::** basic weston(wayland compositor) config.
+ Net
    + **vimperator**              **::** config for the greatest "deprecated" firefox-addon. Vim-like keybindings and UX in firefox.
    + **w3m**                     **::** some copypaste for w3m.
    + **stig**                    **::** custom colorscheme for this nice transmission-client
+ IM / Mail / News
    + **telegram**                **::** nothing
    + **weechat**                 **::** basic weechat config. It's not so perfect as it can be because I am not hardcore IRC-user.
    + **irssi**                   **::** basic config for this basic irssi, stolen from somewhere
    + **mutt**                    **::** famous cli-based mail-client
    + **newsboat**                **::** cli newsbeuter-based rss-reader.
+ Media
    + **mpv**                     **::** my minimalistic video player config.
    + **sxiv**                    **::** config for my fork of sxiv, image viewer.
+ Emulators
    + **dos**                     **::** configs for dos emulators.
+ System
    + **systemd**                 **::** user services(for `systemctl --user`)
        + bashbullet.service
        + caddy.service
        + downloads.service
        + dunst.service
        + email-notification.service
        + log_runner.service
        + mpdas.service
        + mpd-notification.service
        + mpd.service
        + network_applet.service
        + offlineimap.service
        + powerline-daemon.service
        + sxhkd.service
        + transmissiond.service
        + udiskie.service
        + wallpaper.service
        + x11settings.service
+ Doc
    + **zathura**                 **::** nice and tiny pdf/djvu/whatever viewer with UX similar to vim
+ Misc
    + **neofetch**                **::** nice fetch with custom config
    + **npm**                     **::** nothing.
    + **htop**                    **::** basic htop stuff(monochromatic for now)
    + **imgur, imgur-screenshot** **::** imgur uploaders.
    + **minidlna**                **::** basic minidlna config, nothing interesting.
    + **misc**                    **::** various stuff, which I don't use a lot as screenrc, urlview, etc.
    + **offlineimap**             **::** my imap -> local mail fetcher.
    + **task**                    **::** basic config for my GTD-like tool taskwarrior.
    + **ranger**                  **::** nice console-based filemanager. I do not using it a lot, but like picture preview feature(in terminal, based on w3m).
