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
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
### Niri WM ###################################################
  programs.niri = {
    enable = true;
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
### Flatpak ########################################################
  # services.flatpak.enable = true;
  # systemd.services.flatpak-repo = {
  #   wantedBy = [ "multi-user.target" ];
  #   path = [ pkgs.flatpak ];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };
  # services.flatpak = {
  #   enable = true;
  #   packages = [
  #     "md.obsidian.Obsidian"
  #     "com.usebottles.bottles"
  #   ];
  # };
  # environment.variables = {
  #   XDG_DATA_DIRS = lib.mkDefault [
  #     "/var/lib/flatpak/exports/share"
  #     "${config.users.users.vch.home}/.local/share/flatpak/exports/share"
  #   ];
  # };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      # xdg-desktop-portal-gtk
    ];
  };
  hardware.nvidia = {
    enable = true;
    modesetting.enable = true;
    # Используйте 'true' для открытых модулей (новые карты) или 'false' для проприетарных (старые).
    # Проверьте документацию NVIDIA или вики NixOS для своей карты.
    open = true;
  };

  # Включение драйверов NVIDIA для X-сервера
  services.xserver.videoDrivers = [ "nvidia" ];

  # Добавляем 32-битные библиотеки, которые нужны для Wine/Bottles
  hardware.opengl.driSupport32Bit = true;

  # Включите свободные пакеты, так как драйвер NVIDIA — проприетарный
  nixpkgs.config.allowUnfree = true;
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

