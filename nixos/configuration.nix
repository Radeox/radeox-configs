# Radeox - Nix #

{ config, lib, pkgs, ... }:

{
  # Include external configuration
  imports = [ ./hardware-configuration.nix ];

  # Bootloader configuration
  boot = {
    # Use latest kernel
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    # Enable secure boot
    bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    # Setup keyfile
    initrd.secrets = { "/crypto_keyfile.bin" = null; };

    # Use nvidia driver
    initrd.kernelModules = [ "nvidia" ];

    # NTFS support
    supportedFilesystems = [ "ntfs" ];

    extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];
  };

  # Networking configuration
  networking = {
    # Define your hostname
    hostName = "Radeox-Nix";

    # Enable networking
    networkmanager.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    # Automatic Garbage Collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    # Optimize store
    settings.auto-optimise-store = true;

    # Enable flakes
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # User packages
  users.users.radeox = {
    isNormalUser = true;
    description = "Radeox";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = (with pkgs; [
      alacritty
      ansible
      anytype
      authenticator
      autojump
      bat
      cargo
      discord
      drill
      du-dust
      duf
      fd
      ffmpeg
      filezilla
      firefox
      gimp
      gnome.gnome-tweaks
      google-chrome
      heroic
      home-manager
      imagemagick
      inkscape
      killall
      lazydocker
      lazygit
      libreoffice-fresh
      lsd
      lutris
      megasync
      mongodb-compass
      mongodb-tools
      newsflash
      ngrok
      nixfmt
      nodejs_20
      openfortivpn
      php82
      poetry
      prismlauncher
      protonup-qt
      qogir-icon-theme
      remmina
      rpi-imager
      scrcpy
      spotify
      steam
      telegram-desktop
      thunderbird
      tuba
      veracrypt
      vifm
      vlc
      vorta
      vscode
      yuzu-mainline
    ]) ++ (with pkgs.gnomeExtensions; [
      appindicator
      clipboard-indicator
      color-picker
      dash-to-dock
      espresso
      gsconnect
      quick-settings-tweaker
      user-themes
    ]);
  };

  # System packages
  environment.systemPackages = with pkgs; [
    cifs-utils
    cmake
    docker
    docker-compose
    gcc
    git
    gnumake
    htop
    linuxPackages_xanmod_latest.xone
    noto-fonts
    pciutils
    python311
    python311Packages.pip
    ripgrep
    sbctl
    unzip
    wayland-utils
    wget
    wl-clipboard
    zip
    zsh
  ];

  # Exclude some Gnome packages
  environment.gnome.excludePackages =
    (with pkgs; [ gnome-console gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [
      epiphany
      geary
      gedit
      gnome-calendar
      gnome-music
      gnome-software
      gnome-terminal
      totem
    ]);

  services = {
    xserver = {
      # Enable X11
      enable = true;

      # Use the nvidia driver
      videoDrivers = [ "nvidia" ];

      # Enable Gnome
      desktopManager.gnome.enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "";

      # Enable touchpad support
      libinput.enable = true;

      # Remove xterm from gnome-terminal
      excludePackages = [ pkgs.xterm ];
    };

    # Enable flatpak
    flatpak.enable = true;

    # Enable printing services
    printing = { enable = true; };

    # Enable network discovery
    avahi = {
      enable = true;
      nssmdns = true;
    };

    # Enable Samba shares
    gvfs.enable = true;

    # Pipewire configuration
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # TLP configuration
    tlp = {
      enable = true;

      settings = {
        # CPU Govenor = schedutil
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # CPU frequency scaling (AC)
        CPU_SCALING_MIN_FREQ_ON_AC = 400000;
        CPU_SCALING_MAX_FREQ_ON_AC = 4600000;

        # CPU frequency scaling (BAT)
        CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 1200000;

        # Charge thresholds
        STOP_CHARGE_THRESH_BAT0 = 1;
      };
    };

    # Enable thermald
    thermald.enable = lib.mkDefault true;

    # Disable power profiles
    power-profiles-daemon.enable = false;
  };

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  programs = {
    # Enable ZSH
    zsh.enable = true;

    # Neovim as default editor
    neovim = {
      enable = true;
      defaultEditor = true;

      # Alias to neovim
      viAlias = true;
      vimAlias = true;
    };

    # Configure Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    # Enable Gamemode
    gamemode.enable = true;

    # Enable GTK themes in Wayland
    dconf.enable = true;
  };

  # Set ZSH as default shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  system = {
    # Auto system update
    autoUpgrade = { enable = true; };

    # Pretty rebuild messages
    activationScripts.diff = {
      supportsDryActivation = true;
      text = ''
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
      '';
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "23.05";
  };

  virtualisation = {
    # Enable docker
    docker = {
      enable = true;
      enableNvidia = true;
      liveRestore = false;
    };
  };

  hardware = {
    nvidia = {
      # Modesetting is needed for most wayland compositors
      modesetting.enable = true;

      # Enable power management
      powerManagement.enable = true;

      # Don't use the open source version
      open = false;

      # Nvidia settings GUI
      nvidiaSettings = false;

      # Driver version
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };

    # Enable bluetooth
    bluetooth.enable = true;

    # Make sure opengl is enabled
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        nvidia-vaapi-driver
        vaapiVdpau
      ];
    };

    # Enable the Xbox One driver
    xone = { enable = true; };
  };

  # Firewall configuration
  networking.firewall = {
    enable = true;

    # Dev ports
    allowedTCPPorts = [ 8080 8082 9003 9080 ];

    # KDE Connect
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
  };

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Configure extra fonts
  fonts.packages = with pkgs;
    [
      (nerdfonts.override {
        fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
      })
    ];

  # Set Wayland ozone backend
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
