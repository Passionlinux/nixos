# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./glf
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "debiancerlinux"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment. (géré par /glf/gnome.nix)
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.gnome.games.enable = true;  
  #services.xserver.displayManager.defaultSession = "gnome";
  
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
    
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;

  # Pour l'utilisation de flatpak:
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #xdg.portal.config.common.default = "gtk";
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.avahi.enable = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;
  # for an USB printer
  #services.ipp-usb.enable = true;
  # scan
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  # Activer le Bluetooth
  hardware.bluetooth.enable = true;
  #hardware.bluetooth.package = [ pkgs.bluez ];
  services.blueman.enable = false;
  hardware.bluetooth.powerOnBoot = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sebastien = {
    isNormalUser = true;
    description = "Sebastien CHAVAUX";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "disk" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "sebastien";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox. (géré dans /glf/firefox.nix)
  #programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   appimage-run
   amule
   aspell
   aspellDicts.fr
   #blueman
   bashInteractiveFHS
   #bluez
   bluez-tools
   brasero
   btop-cuda
   cataclysm-dda
   claws-mail
   deluge
   detox
   dgen-sdl
   discord
   enchant
   fceux
   filezilla
   flare
   #flatpak
   gimp
   git
   glaxnimate
   gnome-boxes
   gnome-tweaks
   gnome-multi-writer
   gnomeExtensions.gsconnect
   gspell
   simple-scan
   hexchat
   hplip
   htop
   hugo
   humanity-icon-theme
   hunspell
   hunspellDicts.fr-moderne
   hunspellDicts.fr-any
   hunspellDicts.fr-classique
   ispell
   kdePackages.ghostwriter
   kdePackages.kdenlive
   libsForQt5.kdenlive
   libsForQt5.soundkonverter
   kdePackages.libkdegames
   lftp
   libreoffice
   mc
   minidlna
   luanti
   mldonkey
   mplayer
   mpv
   neofetch
   nestopia-ue
   nodejs_22
   ntfs3g
   obs-studio
   p7zip
   pitivi
   qbittorrent
   quodlibet
   retroarchFull
   rocksndiamonds
   scummvm
   smplayer
   soundconverter
   sound-juicer
   the-legend-of-edgar
   thunderbird
   typora
   ubuntu_font_family
   vlc
   wesnoth
   wget
   wine-staging
   #vscode-with-extensions
   vscode-fhs
   #xsane
   #xarchiver
   #xfce.thunar-archive-plugin
   #xfce.thunar-volman
   #xfce.xfce4-pulseaudio-plugin
   #xfce.xfce4-volumed-pulse
   yaru-theme
   yt-dlp
   zeroad-unwrapped
   zola
   
   # Polices
   noto-fonts
   noto-fonts-cjk-sans
   noto-fonts-emoji
   
   # Themes
   adw-gtk3
   graphite-gtk-theme
   tela-circle-icon-theme
  ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-25.05";
  nix.optimise.automatic = true;
  nix.gc = {
   automatic = true;
   dates = "weekly";
   options = "--delete-older-than 15d";
};
  nix.settings.auto-optimise-store = true;
 
  ##Commandes Experimentales
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
}
