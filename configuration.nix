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
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        editor = true;
      };

      efi.canTouchEfiVariables = true;
    };
  };

  # Users configuration
  users = {
    defaultUserShell = pkgs.fish; # Global default shell
    users.kewb = {
      isNormalUser = true;
      description = "kewbionic";
      # home = "/home/kewb";
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

    gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
      options = "--delete-older-than 3d";
    };
  };

  # Networking configuration
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
    hostName = "pissbrick";
    networkmanager.enable = true;
    nameservers = [
      "2606:4700:4700::1111"
      "1.1.1.1"
      "2606:4700:4700::1001"
      "1.0.0.1"
    ];
  };

  # Time settings
  time.timeZone = "America/New_York";

  # Internationalization settings
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # TODO You dont need to specify the ones under this, since they will use the default locale
    # extraLocaleSettings = {
    #   LC_ADDRESS = "en_US.UTF-8";
    #   LC_IDENTIFICATION = "en_US.UTF-8";
    #   LC_MEASUREMENT = "en_US.UTF-8";
    #   LC_MONETARY = "en_US.UTF-8";
    #   LC_NAME = "en_US.UTF-8";
    #   LC_NUMERIC = "en_US.UTF-8";
    #   LC_PAPER = "en_US.UTF-8";
    #   LC_TELEPHONE = "en_US.UTF-8";
    #   LC_TIME = "en_US.UTF-8";
    # };
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
    nautilus

    # CLI tools
    wineWow64Packages.stagingFull
    nh
    fd # Fast "find" command alternative
    btop-cuda # CLI Task manager
    gdu # filesize usage CLI tool
    bat # Nicer "cat" alternative
    dysk # Diskusage CLI tool
    fastfetch # system information

    # Deps
    polkit_gnome
    gnome-keyring
    gcr # Added for compatibility with gnome-keyring packages

    # Theming (mostly for nautilus and other gnome apps)
    adwaita-icon-theme
    adw-gtk3
  ];

  # Programs configuration
  programs = {
    steam.enable = true;
    fish.enable = true;
    foot.enable = true;

    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

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

    displayManager.gdm.enable = true;

    xserver = {
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    tetrd.enable = true;

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

  # This option defines the first version of NixOS you installed on this machine.
  # This is used for compatibility.
  # Do NOT change this after installing.
  system.stateVersion = "25.11";
}
