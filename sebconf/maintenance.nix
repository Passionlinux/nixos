{ config, pkgs, lib, ... }:

{
  # ==========================================================
  # Auto-upgrade système – Gaming-ready 🐓💨
  # ==========================================================
  system.autoUpgrade = {
    enable = true;                               # Active l'auto-upgrade
    operation = "switch";                        # Build + activation automatique
    allowReboot = false;                         # Pas de reboot automatique
    channel = "https://channels.nixos.org/nixos-25.11"; # Channel utilisé
    dates = "Fri 19:00";                         # 1 run par semaine
    randomizedDelaySec = "5min";                 # Décalage léger pour éviter collisions
    # persistent = false  # Pas nécessaire avec deux runs/semaine
    # Fenêtre reboot si un jour allowReboot = true
    # rebootWindow = {
    #   lower = "02:00";  # début fenêtre
    #   upper = "05:00";  # fin fenêtre
    # };
    # fixedRandomDelay = false  # Pas utile sur PC solo
  };

  # ==========================================================
  # Optimisation automatique du store Nix
  # ==========================================================
  nix.optimise = {
    automatic = true;             # Active l'optimisation des binaires
    dates = [ "daily" ];          # Tous les jours
    randomizedDelaySec = "5min";  # Décalage léger pour éviter collision avec upgrade ou GC
    persistent = false;           # Pas nécessaire pour PC souvent allumé
  };

  # ==========================================================
  # Garbage collector
  # ==========================================================
  nix.gc = {
    automatic = true;             # Active le garbage collector
    dates = [ "weekly" ];         # Hebdo suffit pour SSD / Steam / Wine
    options = "--delete-older-than 15d"; # Supprime ce qui a >15 jours
    randomizedDelaySec = "5min";  # Décalage léger pour éviter collision avec upgrade ou optimise
    persistent = false;           # Pas nécessaire pour PC allumé régulièrement
  };

  # ==========================================================
  # Optimisation automatique des fichiers identiques
  # ==========================================================
  nix.settings.auto-optimise-store = true;
  # Nix détecte les fichiers identiques dans le store et les remplace par des hardlinks
  # Utile pour Steam / Wine / Proton, économise beaucoup de place

  # ==========================================================
  # Fonctionnalités expérimentales
  # ==========================================================
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  # flakes : support expérimental des flakes
  # nix-command : active la nouvelle CLI Nix
}
