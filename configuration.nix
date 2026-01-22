{Config, pkgs, ...}:

{
    #Imports
    imports = [
        # put hardware shit here once I get onto Nix & whatever else is needed
        spicetify-nix.homeManagerModules.spicetify
    ];

    boot = {
        # still working on this, pain in my ass because I'm stoopid, not even sure this is correct either :sob:
        efi.canTouchEfiVariables = true;

        # Gonna have to get help for the pipewire shit
    };

    # Users (100% unfinished, without a doubt)
    users.users.kewb = {
        isNormalUser = true;
        description = "kewbionic";
        home = "/home/kewb";
        extraGroups = ["wheel" "audio" "video"];
    };

    # Default shell acrosss the system
    environment.defaultShell = pkgs.fish;


    networking = {
        firewall = {
            enable = true;
            allowedTCPPorts = [];
            allowedUDPPorts = [];
        };
        hostName = "pissbrick";
        networkmanager.enable = true;
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

        # Proton my beloved
        proton-pass
        protonmail-desktop
        proton-authenticator
        
        # other
        gimp
        zed-editor
        lmms
        vscodium
        obsidian
        pulseaudio
        wineWowPackages.stableFull
        nautilus
        polkit_gnome
    ];

    programs = {
        steam.enable = true;
        fish.enable = true;
        foot.enable = true;
        spicetify = {
            enable = true;
            #config options
        };
    };

    fonts = {
        fontconfig.enable = true;
        # Gives fonts a directory to be held in
        enableFontDir = true;
        fonts = with pkgs; [
            jetbrains-mono
            google-fonts
        ];
    };

    hardware = {
        graphics.enable = true;
        nvidia.open = true;
        
        #nvidih (working on this still)
        nvidia = {
            modesetting.enable = true;

            prime = {
                offload.enable = true;
                # Smth about BusIDs
                intelBusId = "pci@0000:00:02.0";
                nvidiaBusId = "pci@0000:01:00.0";
            };
        };
    };

    # Enable shit (also still working on this)
    nix.config = {
        allowUnfree = true;
    };

    # Services
    services = {
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;

            wireplumber = {
                enable = true;
            };
        };  
        
        xserver = {
            videoDrivers = ["nvidia"];
        };
        openssh.enable = true;
        libinput.enable = true;

        displayManager.gdm.enable = true;

        gnome.gnome-keyring.enable = true;
        dbus.packages = [pkgs.gnome.gnome-keyring pkgs.gcr]


    };

    security = {
        pam.services.gdm.enableGnomeKeyring = true;
        polkit.enable = true;
    };


















































}
