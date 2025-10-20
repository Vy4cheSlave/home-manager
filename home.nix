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

      # niri ##############
      swaybg
      #####################
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
  # niri ##############################################################################################
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;

  programs.alacritty.enable = true; # Super+T in the default setting (terminal)
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  programs.waybar.enable = true; # launch on startup in the default setting (bar)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.shellAliases = {
    codium = "codium --wayland-text-input-version=3";
  };
  #####################################################################################################
}
