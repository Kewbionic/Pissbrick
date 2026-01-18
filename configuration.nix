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
        IsNormalUser = true;
        description = "kewbionic";
        home = "/home/kewb";
        extraGroups = []
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

        # other
        gimp
        zed-editor
        lmms
        vscodium
        obsidian
        pulseaudio
        
        # Proton my beloved
        proton-pass
    ];


    programs = {
        steam.enable = true;
        fish = enable;
        spicetify = {
            enable = true;
            #config options
        };
    };

    hardware = { 
        #nvidih (working on this still)
        nvidia.modesetting.enable = true;
        nvidia.open = true;

        nvidia.prime = {
            offload.enable = true;
            # Smth about BusIDs
            intelBusID = "???";
            nvidiaBusID = "???";
        };
    };

    # Enable shit (also still working on this)
    nix.config = {
        allowUnfree = true;
    }




    # Nvidia drivers and other shit
        hardware.nvidia.package

        # Don't remember if I needed to change any of this so I'm just gonna comment it all

        #hardware.opengl.driSupport32Bit = false;
        #hardware.bluetooth.enable = true;
        #hardware.pulseaudio = {
        #enable = true;
    };  

    # Services
    services = {
        # I think?
        xserver.videoDrivers = ["nvidia"];

        # Saw it on the nix package shit and figured i'd want this aswell
        openssh.enable = true;
    };




















































};