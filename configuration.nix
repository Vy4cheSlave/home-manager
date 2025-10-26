# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.

    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.networkmanager.insertNameservers = [ "8.8.8.8" "1.1.1.1" "8.8.4.4" ];

  # Set your time zone.
  time.timeZone = "Asia/Novosibirsk";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
### Nekoray ##########################################################
  security.wrappers.nekobox_core = {
    enable = true;
    source = "${pkgs.nekoray.nekobox-core}/bin/nekobox_core";
    program = "nekobox_core";
    owner = "vch";   # твой пользователь
    group = "users";
    capabilities = "cap_net_admin+ep";
  };
######################################################################

### Fonts ######################
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];

  fonts.enableDefaultPackages = true; 
################################

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";
  console = {
    font = "Lat2-Terminus16";
  #   keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #services.xserver = {
  #  displayManager.sessionCommands = ''
  #    xset r rate 200 35 &
  #  '';
  #};

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
### Niri WM ###################################################
  programs.niri = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
###############################################################

  # Configure keymap in X11
  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio = {
  #   enable = true;
  #   support32Bit = true;
  # };
  # services.pipewire.enable = lib.mkForce false;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

### Bluetooth ######################################################
  hardware.bluetooth = {
    enable = true;                # Включить Bluetooth
    powerOnBoot = true;          # Включить Bluetooth при загрузке
    package = pkgs.bluez;        # Использовать пакет bluez
    settings = {
      General = {
        Experimental = true;      # Функции Bluetooth могут быть экспериментальными
        FastConnectable = true;   # Ускорить подключение
      };
      Policy = {
        AutoEnable = true;        # Автоматически включать контроллеры
      };
    };
  };
  services.blueman.enable = true;
####################################################################
### Steam ##########################################################
programs.xwayland.enable = true;
services.xserver.xwayland.enable = true;
programs.gamemode.enable = true; # улучшение производительности
programs.steam = {
  # settings->general->launch options->
  # gamemoderun %command% / gamescope %command%
  enable = true;
  gamescopeSession.enable = true; # проблемы с масштабированием
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
####################################################################
### Flatpak ########################################################
### Лучше вручную ничего не удалять, только через конфиг ###########
  services.flatpak = {
    enable = true;
    packages = [
      "md.obsidian.Obsidian"
      "com.usebottles.bottles"
      "com.github.tchx84.Flatseal"
    ];
    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = ["wayland" "!x11" "!fallback-x11"];

        Environment = {
          # Fix un-themed cursor in some Wayland apps
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

          # Force correct theme for some GTK apps
          GTK_THEME = "Adwaita:dark";
        };
      };

      # НЕ РАБОТАЕТ(или работает я хуй знает) (НАСТРАИВАЙ ВРУЧНУЮ)
      "md.obsidian.Obsidian".Context = {
        filesystems = [
          "xdg-config/git/config:ro"
          "/run/current-system/sw/bin:ro"
        ];
        Environment = [
          # "GIT_CONFIG_GLOBAL=/home/vch/.config/git/config"
        ];
      };
      "com.usebottles.bottles".Context = {
        # Явно указываем, что Bottles должен использовать NVIDIA GPU
        # Это может помочь в гибридных системах
        Environment = [
          # "DRI_PRIME=1"
          "__GLX_VENDOR_LIBRARY_NAME=nvidia"
          "__NV_PRIME_RENDER_OFFLOAD=1"
        ];
        # Дополнительно можно добавить сокет X11 на всякий случай
        # Это не должно быть нужно, если вы в Wayland, но иногда помогает
        sockets = [ "x11" ];
        devices = [ "dri" ];
      };

      # "com.visualstudio.code".Context = {
      #   filesystems = [
      #     "xdg-config/git:ro" # Expose user Git config
      #     "/run/current-system/sw/bin:ro" # Expose NixOS managed software
      #   ];
      #   sockets = [
      #     "gpg-agent" # Expose GPG agent
      #     "pcsc" # Expose smart cards (i.e. YubiKey)
      #   ];
      # };
      # "org.onlyoffice.desktopeditors".Context.sockets = ["x11"]; # No Wayland support
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config = {
      niri = {
        default = [ "wlr" "gtk" ]; # Использовать wlr как основной, gtk как запасной
      };
      # Настройки по умолчанию
      common = {
        default = [ "wlr" "gtk" ];
      };
    };
  };
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
  };
  hardware.nvidia = {
    # Включение modesetting обязательно для работы
    modesetting.enable = true;
    
    # Выбор между открытыми и проприетарными модулями ядра
    # Используйте 'true' для современных карт (RTX 20 и новее)
    # Используйте 'false' для старых карт (GTX 10 и старше)
    open = false; # Или false, в зависимости от вашей карты
    # Включение prime offloading
    prime = {
      offload = { # использование видеокарты nvidia nvidia-offload %some-game%
        enable = true;
        enableOffloadCmd = true;
      };
      # Bus ID интегрированной графики Intel
      intelBusId = "PCI:0:2:0";
      # Bus ID дискретной графики NVIDIA
      nvidiaBusId = "PCI:1:0:0";
    };

    # Необязательная опция: включение утилиты nvidia-settings
    nvidiaSettings = true;
  };

  # Включение драйверов NVIDIA для X-сервера
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  # Добавляем 32-битные библиотеки, которые нужны для Wine/Bottles
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
####################################################################

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vch = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

