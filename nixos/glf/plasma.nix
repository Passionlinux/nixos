{ config, pkgs, ... }:

{
  # Activer le serveur d’affichage Plasma
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;

  # Wayland (optionnel mais recommandé pour Plasma 6)
  services.xserver.displayManager.sddm.wayland.enable = true;

  # Applications KDE (ensemble complet)
  environment.systemPackages = with pkgs; [
    # Paquets de base
    kdePackages.kde-cli-tools
    kdePackages.kde-gtk-config
    kdePackages.plasma-workspace
    kdePackages.systemsettings
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.okular
    kdePackages.gwenview
    kdePackages.ark
    kdePackages.kdenlive
    kdePackages.kmail
    kdePackages.kontact
    kdePackages.korganizer
    kdePackages.kget
    kdePackages.kolourpaint
    kdePackages.krdc
    kdePackages.krfb
    kdePackages.ksshaskpass
    kdePackages.kdeconnect-kde
    kdePackages.kdeplasma-addons

    # Suite KDE applications complètes
    kdePackages.kdeApplications
  ];

  # Thèmes et icônes
  services.xserver.desktopManager.plasma6.enableQt5Integration = true;

    services.printing.enable = true;

  # Polices
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
