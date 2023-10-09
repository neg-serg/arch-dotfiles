# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.extraOptions = ''
  experimental-features = nix-command flakes
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow"; # Set your time zone.
  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  sound.enable = true; # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };


  services.xserver.displayManager.sessionPackages = [ pkgs.gnome.gnome-session.sessions ];

  environment.gnome.excludePackages = (with pkgs; [
		  gnome-photos
		  gnome-tour
		  gnome-text-editor
  ]) ++ (with pkgs.gnome; [
	  cheese # webcam tool
	  gnome-music
	  gnome-terminal
	  epiphany # web browser
	  geary # email reader
	  evince # document viewer
	  gnome-characters
	  totem # video player
	  tali # poker game
	  iagno # go game
	  hitori # sudoku game
	  atomix # puzzle game
	  gnome-calculator
	  yelp # help viewer
	  gnome-maps
	  gnome-weather
	  gnome-contacts
  ]);


  users.groups.mlocate = {};
  users.groups.plocate = {};

  users.users.neg = {
    isNormalUser = true;
    description = "neg";
    extraGroups = [ "networkmanager" "wheel" "tty" "audio" "video" "plocate" "mlocate" "input" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      telegram-desktop
      mpv

      delta

      dex dunst polybar

      kitty fzf-zsh rofi fasd

      xdg-utils
      xsettingsd

      plocate

      i3 python311Packages.i3-py
    ];
  };

  # # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "neg";
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git tig
    neovim
    zsh
    atop
    stow

    picom
    tmux
    xiccd

    wget2

    mpd ncmpcpp mpc-cli mpdas
    ncpamixer

    fzf fzf-zsh
    tmux dash fd ripgrep jq

    python311
    
    efibootmgr
    
    gparted
    gnome.gpaste

    openrgb
    iosevka

    xorg.xorgserver
    xorg.xf86inputevdev
    xorg.xf86inputlibinput
    xorg.xinit
    xorg.xauth
    xorg.xrandr
    xorg.xrdb
    xorg.setxkbmap
    xorg.iceauth
    xorg.xset
    xorg.xinput
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # # Load nvidia driver for Xorg and Wayland
  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true; # Modesetting is required.
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
