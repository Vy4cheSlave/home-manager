{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      
    ];

    username = "vch";
    homeDirectory = "/home/vch";

    stateVersion = "25.05";
  };

  targets.genericLinux.enable = true; # ENABLE THIS ON NON NIXOS
  programs.home-manager.enable = true;
}
