{ lib, pkgs, ... }:
{
  imports = [ 
    ./web-browser/librefox.nix 
  ];

  home = {
    packages = with pkgs; [
      # fonts #################
      jetbrains-mono 
      nerd-fonts.jetbrains-mono
      nerd-fonts.nerd-fonts-agave
      nerd-fonts._3270
      #########################
      ghostty
      #librewolf
      helix
      git
      gnumake
      vscodium
      #obsidian
      nekoray
      btop
      #rofi
      # не разобрался как работает пока
      # zapret
      # nftables      

      # niri ##############
      swaybg
      #####################
      # eww ###############
      libnotify
      #####################
    ];

    username = "vch";
    homeDirectory = "/home/vch";

    stateVersion = "25.05";
  };

  programs.obsidian = {
    enable = true;
    # я ебал этого пидараса
    #vaults.obsidian.target = "documents/obsidian";
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
  # niri ##############################################################################################
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;

  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  programs.waybar.enable = true; # launch on startup in the default setting (bar)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

  programs.eww = {
    enable = true;
    #configDir = ./bar/eww;
  };
  #####################################################################################################
}
