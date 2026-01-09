{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    thunderbird
    hunspell
    hunspellDicts.fr-any
    # --- Les ajouts d'intégration ---
    kdePackages.kdepim-addons
    libnotify
  ];

  # le dictionnaire
  environment.variables = {
    LANG = "fr_FR.UTF-8";
    LC_ALL = "fr_FR.UTF-8";
    DICPATH = "${pkgs.hunspellDicts.fr-any}/share/hunspell";
    GTK_USE_PORTAL = "1"; # Pour que Thunderbird utilise Dolphin
  };

  # Indispensable pour l'affichage propre des mails reçus
  fonts.packages = with pkgs; [
    liberation_ttf
  ];
}
