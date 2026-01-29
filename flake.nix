{
  description = "Kewb's system";

  # Any flakes you want to add go here
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # NixOS official package source
    nixpkgs-tetrd.url = "github:MrSn0wy/nixpkgs/update-tetrd"; # nixpkgs fork for tetrd
  };

  outputs =
    { self, ... }@inputs:
    let
      system = "x86_64-linux";
      tetrd-pkgs = import inputs.nixpkgs-tetrd {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # The pissbrick system
      nixosConfigurations.pissbrick = inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        # your "imports"
        modules = [
          {
            # overlays on your system's nixpkgs
            nixpkgs.overlays = [
              (final: prev: {
                # Replaces the tetrd of your nixpkgs to the custom version
                tetrd = tetrd-pkgs.tetrd;
              })
            ];

            # replace tetrd module
            disabledModules = [ "services/networking/tetrd.nix" ];
            
            imports = [
              "${inputs.nixpkgs-tetrd}/nixos/modules/services/networking/tetrd.nix"
            ];
          }

          # your system configs...
          ./configuration.nix
        ];
      };
    };
}
