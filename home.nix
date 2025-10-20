{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      jetbrains-mono # fonts
      ghostty
      #librewolf
      helix
      git
      gnumake
      vscodium
      #obsidian
      #rofi
      # не разобрался как работает пока
      # zapret
      # nftables      
    ];

    username = "vch";
    homeDirectory = "/home/vch";

    stateVersion = "25.05";
  };

  programs.zsh = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "Vy4cheSlave";
    userEmail = "slav.subocheff@yandex.ru";
  };

  targets.genericLinux.enable = true; # ENABLE THIS ON NON NIXOS
  programs.home-manager.enable = true;
}
