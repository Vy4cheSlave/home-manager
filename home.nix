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
      nerd-fonts.agave
      nerd-fonts._3270
      #########################
      ghostty
      #librewolf
      helix
      git
      gnumake
      vscodium
      nekoray
      btop
      nautilus
      #rofi
      # не разобрался как работает пока
      # zapret
      # nftables      

      # niri ##############
      swaybg
      #####################
      # eww ###############
      libnotify
      jq
      #####################
      pciutils
      #####################
      protonup
    ];

    username = "vch";
    homeDirectory = "/home/vch";

    stateVersion = "25.05";
  };

  programs.yazi = {
    enable = true;
  };
  programs.steam = {
    # settings->general->launch options->
    # gamemoderun %command% / gamescope %command%
    enable = true;
    gamescopeSession.enable = true; # проблемы с масштабированием
    gamemode.enable = true; # улучшение производительности
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  # programs.obsidian = {
  #   enable = true;
  #   vaults.obsidian = {
  #     enable = false;
  #     target = "obsidian";
  #     settings = {
  #       extraFiles = {
  #         ".obsidian" = {
  #           source = ~/obsidian/.obsidian;
  #           target = ".obsidian";
  #         };
  #       };
  #     };
  #   };
  # };
  programs.zsh = {
    enable = true;
  };
  programs.git = {
    enable = true;
    settings.user.name = "Vy4cheSlave";
    settings.user.email = "slav.subocheff@yandex.ru";
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
  # flatpak############################################################################################
  xdg = {
    enable = true;
    systemDirs.data = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };
  #####################################################################################################
}
