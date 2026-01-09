{ config, pkgs, lib, ... }:
{
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      media_dir = [
        "V,/home/sebastien/Vidéos"
      ];
      wide_links = "yes";
      friendly_name = "Mon-Serveur-DLNA";
      inotify = "yes";
      notify_interval = 10;
      album_art_names = "Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg";
      log_level = "info";
      # Boost pour grosses bibliothèques :
      strict_dlna = "no";             # plus permissif avec les fichiers
      inotify_queue_size = "8192";    # augmente la taille de la queue inotify (default 8192, tu peux monter si beaucoup de fichiers)
      max_connections = "100";        # nombre max de connexions simultanées
      root_container = "V";           # utile pour certains clients UPnP
      presentation_url = "/";         # URL de la page web (si tu utilises un navigateur pour DLNA)
    };
  };
}
