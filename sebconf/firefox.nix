{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    wrapperConfig = {
        pipewireSupport = true;
      };
    languagePacks = [ "fr" "en-US" ];

    # Ajoute les dictionnaires pour le correcteur orthographique
    nativeMessagingHosts.packages = [ pkgs.firefoxpwa ]; # Optionnel : pour les web-apps

    preferences = {
      "intl.accept_languages" = "fr-fr,en-us,en";
      "intl.locale.requested" = "fr,en-US";
      "widget.use-xdg-desktop-portal.file-picker" = 1;

      # --- Optimisations Vidéo & GPU ---
      "media.ffmpeg.vaapi.enabled" = true;
      "media.hardware-video-decoding.force-enabled" = true;
      "gfx.webrender.all" = true; # Utilise le GPU pour tout le rendu du navigateur

      # --- Vie privée & Confort ---
      "browser.bookmarks.restore_default_bookmarks" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false; # Pas de pub au démarrage
      "browser.newtabpage.activity-stream.feeds.snippets" = false; # Vire les messages de Mozilla
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false; # Vire les sites épinglés de pub
      "browser.shell.checkDefaultBrowser" = false;
      #"dom.security.https_only_mode" = true; # HTTPS partout
    };
  };

  # Pour que le correcteur orthographique fonctionne bien
  environment.systemPackages = [ pkgs.hunspell pkgs.hunspellDicts.fr-moderne ];
}
