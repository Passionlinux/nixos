{ config, pkgs, ... }:

{
  # Activer le gestionnaire de connexion (tu peux garder celui que tu as ou utiliser lightdm)
  services.xserver.displayManager.lightdm.enable = true;

  # Activer XFCE
  services.xserver.desktopManager.xfce.enable = true;

  # Applications XFCE supplémentaires
  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.xfce4-terminal
    xfce.xfce4-screenshooter
    xfce.xfce4-taskmanager
    xfce.xfce4-screensaver
    xfce.xfce4-clipman-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-weather-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-notifyd
    xfce.ristretto   # visionneuse d’images
    xfce.mousepad    # éditeur de texte léger
    xfce.parole      # lecteur multimédia
    xfce.xfburn      # gravure de CD/DVD
    xfce.gigolo      # montage de systèmes de fichiers
  ];

  # Polices
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
