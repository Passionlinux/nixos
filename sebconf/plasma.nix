{ config, pkgs, ... }:

{
  # Activer le serveur d’affichage Plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Wayland (optionnel mais recommandé pour Plasma 6)
  services.displayManager.sddm.wayland.enable = true;

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
    kdePackages.kolourpaint       # application de dessin simple
    kdePackages.krdc
    kdePackages.krfb
    kdePackages.ksshaskpass
    kdePackages.kdeconnect-kde
    kdePackages.kdeplasma-addons
    kdePackages.discover          # facultatif : gestionnaires Flatpak / fwupd
    kdePackages.kcharselect       # sélecteur de caractères spéciaux
    kdePackages.kcolorchooser     # sélection de couleur
    kdePackages.ksystemlog        # journal système KDE
    kdePackages.sddm-kcm          # module de config SDDM dans System Settings
    kdePackages.skanpage
    kdePackages.skanlite

    # Suite bureautique
    kdePackages.calligra

    # Autres outils pratiques
    kdiff3                        # comparateur de fichiers
    kdePackages.kompare           # un autre comparateur de fichiers
    kdePackages.isoimagewriter    # écrire les ISO sur USB
    kdePackages.partitionmanager  # gestionnaire de partitions
    hardinfo2                     # infos système et bench
    kdePackages.ghostwriter
    kdePackages.audex

    # Vidéo & Wayland
    haruna                        # lecteur vidéo basé sur Qt/QML

    # KDEGAMES
    kdePackages.libkdegames
    kdePackages.kpat
    kdePackages.kmahjongg
    kdePackages.kshisen

  ];

  # Thèmes et icônes
  services.desktopManager.plasma6.enableQt5Integration = true;

  # --- Gestion des polices (La touche finale) ---
  fonts = {
    enableDefaultPackages = true;

    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Noto Color Emoji" ];
    };

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];
  };
}
