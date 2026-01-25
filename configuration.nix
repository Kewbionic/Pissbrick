{ config, pkgs, ... }:

{
  # Imports
  imports = [
    ./hardware-configuration.nix
    # spicetify-nix.homeManagerModules.spicetify
  ];

  # Boot configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Users configuration
  users = {
    defaultUserShell = pkgs.fish; # Global default shell
    users.kewb = {
      isNormalUser = true;
      description = "kewbionic";
      home = "/home/kewb";
      extraGroups = [
        "wheel"
        "audio"
        "video"
        "networkmanager"
      ];
    };
  };

  # Nix settings
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];
      auto-optimise-store = true;
      use-xdg-base-directories = true;
    };
  };

  system.stateVersion = "25.11"; # Make sure this matches your desired version

  # Networking configuration
  networking = {
    firewall.enable = true;
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = [ ];
    hostName = "pissbrick";
    networkmanager.enable = true;
  };

  # Time settings
  time.timeZone = "America/New_York";

  # Internationalization settings
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Packages
  environment.systemPackages = with pkgs; [
    # Games
    modrinth-app
    heroic

    # Media
    vlc

    # Social
    signal-desktop
    vesktop

    # Notification Manager
    mako

    # Launcher
    rofi

    # Other
    gimp
    zed-editor
    lmms
    vscodium
    obsidian
    pulseaudio
    wineWowPackages.stableFull
    nautilus
    polkit_gnome
    nh
    fd # Fast "find" command alternative
    gnome-keyring
    gcr # Added for compatibility with gnome-keyring packages
  ];

  # Programs configuration
  programs = {
    steam.enable = true;
    fish.enable = true;
    foot.enable = true;
    # spicetify.enable = true;
  };

  # Fonts configuration
  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
      jetbrains-mono
      google-fonts
    ];
  };

  # Hardware configuration
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = true;
      modesetting.enable = true;
      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # Services configuration
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    xserver = {
      displayManager.gdm.enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    openssh.enable = true;
    libinput.enable = true;
    dbus.packages = [
      pkgs.gnome-keyring
      pkgs.gcr
    ];
  };

  # Security settings
  security = {
    pam.services = {
      gdm.enableGnomeKeyring = true; # Updated for gnome-keyring
      login.enableGnomeKeyring = true; # Ensures keyring unlocks on login
    };
  };
}
