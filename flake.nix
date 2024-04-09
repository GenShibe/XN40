{
  description = "Gen's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          system = "XN40";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            {
              _module.args = {
                inherit inputs;
              };
            }
            { nixpkgs.config.allowUnfree = true; }
            ./hosts/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                users."gen".imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}
