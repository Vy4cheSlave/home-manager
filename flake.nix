{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    niri.url = "github:sodiboo/niri-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let 
      username = "vch";
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in {
      nixosConfigurations = {
        "${username}" = nixpkgs.lib.nixosSystem 
        { 
          system = "${system}"; 
          inherit pkgs;
          modules = [ 
            ./configuration.nix
            (import ./local.nix)

            inputs.niri.nixosModules.niri
            
            inputs.home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${username}" = import ./home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };
    };
}
