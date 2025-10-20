{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # INFO NOT TESTED
    #system-manager = {
    #  url = "github:numtide/system-manager";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #nix-system-graphics = {
    #  url = "github:soupglasses/nix-system-graphics";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { nixpkgs, ... }@inputs:
    let 
      username = "vch";
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in {

      #systemConfigs.default = inputs.system-manager.lib.makeSystemConfig {
      #  modules = [
      #    inputs.nix-system-graphics.systemModules.default
      #    ({
      #      config = {
      #        nixpkgs.hostPlatform = "${system}";
      #        system-manager.allowAnyDistro = true;
      #        system-graphics.enable = true;
      #      };
      #    })
      #  ];
      #};

      #devShells."${system}".default = pkgs.mkShellNoCC {
      #  packages = [
      #    inputs.system-manager.packages."${system}".default
      #  ];
      #};

      #homeConfigurations = {
        #"${username}" = inputs.home-manager.lib.homeManagerConfiguration {
      nixosConfigurations = {
        "${username}" = nixpkgs.lib.nixosSystem { 
          system = "${system}"; 
          inherit pkgs;
          modules = [ 
            #./home.nix 
            ./configuration.nix
            inputs.home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${username}" = import ./home.nix;
                backupFileExtension = "backup";
              };
            }
            #({
            #  home.packages = [ inputs.system-manager.packages."${system}".default ];
            #})
          ];
        };
      };
    };
}
