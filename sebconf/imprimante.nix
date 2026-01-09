{ config, pkgs, ... }:
let
  all-users = builtins.attrNames config.users.users;
  normal-users = builtins.filter (user: config.users.users.${user}.isNormalUser == true) all-users;
in
{
  # --- Configuration de CUPS (Le moteur d'impression) ---
  #systemd.services.cups-browsed.enable = false;
  services.printing = {
    enable = true;
    startWhenNeeded = true;
    drivers = with pkgs; [
      gutenprint
      hplip
      hplipWithPlugin
      samsung-unified-linux-driver
      splix
      brlaser
      brgenml1lpr
      cnijfilter2
    ];
  };

  # --- Détection automatique sur le réseau (Avahi/ZeroConf) ---
  services.avahi = {
    enable = true;
    nssmdns4 = true; # Permet de trouver "imprimante.local" sans IP fixe
    openFirewall = true;
  };

  # --- Support du Scan (SANE) ---
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [ sane-airscan epkowa hplipWithPlugin ];
  };

  # add all users to group scanner and lp
  users.groups.scanner = {
    members = normal-users;
  };
  users.groups.lp = {
    members = normal-users;
  };
}
