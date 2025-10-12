{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      jetbrains-mono # fonts
      ghostty
      librewolf
      helix
      git
      gnumake
      obsidian
      rofi
      # не разобрался как работает пока
      # zapret
      # nftables      
    ];

    username = "vch";
    homeDirectory = "/home/vch";

    stateVersion = "25.05";
  };

  targets.genericLinux.enable = true; # ENABLE THIS ON NON NIXOS
  programs.home-manager.enable = true;
}
