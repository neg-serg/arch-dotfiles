#!/bin/sh
yay -S stow
yay -S patchelf patchutils patool pciutils perf
yay -S bash rlwrap zsh zsh-completions dash mksh babashka-bin inotify-tools
yay -S ansible ansible-lint mitogen
yay -S acpi acpid albumdetails-git alsa-firmware alsa-utils ananicy-git alacritty ansilove-git
yay -S irqbalance
yay -S tizen-sdb android-file-transfer
yay -S antiword asciinema catdoc unrtf
yay -S adobe-icc arandr argyllcms autorandr sampleicc xcalib
yay -S asp pacman-contrib pacvis-git downgrade
yay -S atop htop vmtouch vnstat pv blktrace glances itop pycoinmon smartmontools traceroute tiptop mtr-git fio dmidecode httpflow-git httpie ioping iotop nethogs gptfdisk lm_sensors lshw lsof lsscsi
yay -S tcpdump tcpflow tcptrack wireshark-cli
yay -S iperf iproute2 iputils
yay -S aspell-en aspell-ru
yay -S audit autoconf2.13 autogen
yay -S beets picard split2flac-git flac2all taffy id3 id3v2
yay -S betterdiscordctl-git
yay -S bitwig-studio carla-bridges-win airwave-git
yay -S bzip2 cclive ccls
yay -S clang deheader strace
yay -S cxxmatrix-git
yay -S perl cope-git
yay -S cmatrix convmv cryptsetup cuetools davfs2 ddrescue device-mapper
yay -S diff-so-fancy diffstat diffutils
yay -S docker docker-compose
yay -S dos2unix dosbox-staging dosemu dosfstools
yay -S ffmpeg x264 x265
yay -S easy-rsa efibootmgr
yay -S exiv2
yay -S etckeeper
yay -S dunst
yay -S earlyoom
yay -S firefox firefox-spell-ru browsh-bin
yay -S flawfinder foremost
yay -S gcolor3 gdb gimp
yay -S gita-git gitbatch-bin git-crypt git-extras github-cli git-lfs tig
yay -S gnome-shell gnome-session
yay -S go go-tools
yay -S gpart gparted hddtemp hdparm
yay -S gpaste xsel xclip
yay -S gtk-engine-murrine gtk-engines gtk-engine-unico gtkperf
yay -S hunspell hunspell-ru
yay -S i3-gaps i3-gnome-git i3ipc-python-git caffeine unclutter-xfixes-git wmctrl wmname slop hsetroot gllock-git
yay -S i7z
yay -S imgur-screenshot-git
yay -S jdk8-openjdk jdk-openjdk drip-git icedtea-web
yay -S jq keynav-improved-grid-git kotatogram-desktop-dynamic-bin kvantum-qt5
yay -S licenses
yay -S linux-clear linux-clear-bin linux-clear-headers kexec-tools intel-ucode intel-ucode-clear dkms
yay -S flameshot maim perl-image-exiftool
yay -S lostfiles
yay -S mesa mesa-demos
yay -S modprobed-db
yay -S llvm lsb-release lvm2 lz4 lzo lzop mawk mcomix mdadm
yay -S neofetch inxi
yay -S ncmpcpp mpc mpd mpdas-git mpd-notification-git mpdris2 mpdviz mpvc-git
yay -S neovim-git neovim-remote vi vis ruby-neovim
yay -S netctl netstat-nat nftables nmap
yay -S network-manager-applet networkmanager-openvpn
yay -S notmuch-addrlookup-c notmuchfs-git notmuch-mutt neomutt mbsync
yay -S ntp
yay -S nvidia nvidia-dkms nvidia-settings lib32-nvidia-utils
yay -S nvimpager-git obs-studio
yay -S openbsd-netcat
yay -S openresolv
yay -S openssh openssh-askpass openssl openvpn
yay -S optipng jpegoptim
yay -S p7zip pacgraph
yay -S fontforge cairo-infinality-remix freetype2-infinality-remix fontconfig-infinality-remix pango
yay -S pass pass-import pass-otp
yay -S picom-tryone-git
yay -S polybar-neg-git potrace powerdevil powertop ppi3-git conky-cairo c-lolcat figlet
yay -S prettyping fping-git
yay -S procdump procps-ng progress proxychains-ng
yay -S pulseaudio pulseaudio-alsa pulseaudio-jack pulsemixer-git cadence ncpamixer pamixer pamix-git pavucontrol
yay -S pypy3 pypy3-pip pyright pyenv pyprof2calltree
yay -S python-pip python-pylint python-pynvim
yay -S qemu qemu-block-iscsi qemu-guest-agent spice-vdagent
yay -S qt5ct
yay -S radare2 radare2-bindings-git
yay -S ranger
yay -S xapian recoll
yay -S rofi rofi-pass-git
yay -S rsync sdl2 sshfs
yay -S cdu ripgrep rmlint fd fasd fzf parallel massren mimeo ipython parallel
yay -S steam steamcmd steam-fonts steam-native-runtime
yay -S stig torrentinfo transmission-cli
yay -S stone-soup nethack nethack4 angband gzdoom
yay -S synergy-git
yay -S tar rpmextract unrar
yay -S streamlink stress-ng s-tui sysfsutils sysstat thermald tmatrix-git
yay -S task tasksh
yay -S systemd-boot-pacman-hook
yay -S tmux dtach-git
yay -S toilet
yay -S tor-browser torsocks
yay -S t-prot tracker tracker-miners transline-git tree tsocks
yay -S cozette-otb cozette-ttf ttf-code2000 ttf-iosevka ttf-iosevka-term ttf-ms-win10 ttf-ms-win10-japanese ttf-ms-win10-korean ttf-ms-win10-other ttf-ms-win10-sea ttf-ms-win10-thai ttf-ms-win10-zh_cn ttf-ms-win10-zh_tw
yay -S udiskie
yay -S util-linux valgrind
yay -S vulkan-extra-layers vulkan-headers vulkan-html-docs vulkan-mesa-layer vulkan-tools vulkan-trace vulkan-validation-layers
yay -S xurls urlscan-git urlview
yay -S youtube-dl you-get straw-viewer-git sprunge
yay -S wine wine-mono winetricks dxvk-bin dxvk-cache-server-git vkd3d protontricks-git lib32-vkd3d lutris
yay -S zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps fbless
yay -S zoom discord

mkdir $XDG_DATA_HOME/ncmpcpp

find -maxdepth 1 -type d -not -path '*/\.*' -printf '%P\n' | xargs stow -v
