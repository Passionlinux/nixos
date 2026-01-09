# alias.nix
{ config, pkgs, ... }:

{
  environment.shellAliases = {
    ############################################
    # Fail2ban – Surveillance et stats
    ############################################
    # Voir qui est banni actuellement sur SSH
    bans      = "sudo fail2ban-client status sshd";
    # Voir l'historique des bans dans le journal Fail2ban en temps réel
    banlogs   = "journalctl -u fail2ban -f";
    # Voir les statistiques de récidive
    recidive  = "sudo fail2ban-client status recidive";
    # Voir toutes les jails et leur statut
    alljails  = "sudo fail2ban-client status";

    ############################################
    # Firewall – Inspection et diagnostics
    ############################################
    fwstatus  = "sudo nft list ruleset";
    fwhistory = "sudo journalctl -u nftables -f";

    ############################################
    # --- MAINTENANCE NIXOS ---
    ############################################
    # Appliquer les changements (Rebuild)
    nix-switch = "sudo nixos-rebuild switch";
    # Nettoyer les anciennes générations (libère de l'espace)
    nix-clean  = "sudo nix-collect-garbage -d";
    # Optimiser le stockage (liens physiques identiques)
    nix-opt    = "nix-store --optimise";
    # Éditer la config rapidement (à adapter selon ton éditeur)
    nix-conf   = "sudo nano /etc/nixos/configuration.nix";

    ############################################
    # --- SYSTÈME & RÉSEAU ---
    ############################################
    # Voir les ports ouverts
    ports    = "sudo ss -tulpn";
    # Usage disque clair
    df       = "df -h";
    # Liste détaillée et colorée
    ll       = "ls -la --color=auto";
    # Top moderne (si tu as 'btop' ou 'htop' installé)
    top      = "btop";

    ############################################
    # SSH – Gestion rapide
    ############################################
    sshroot   = "sudo systemctl status sshd";
    sshlogs   = "journalctl -u sshd -f";

    ############################################
    # System – Utilitaires fréquents
    ############################################
    mem       = "free -h";                     # Mémoire libre / utilisée
    disk      = "df -hT";                      # Disques et types
    topx      = "htop";                        # Processus en temps réel
    up        = "uptime";                       # Temps de fonctionnement et charge
    rebootme  = "sudo systemctl reboot";       # Reboot rapide
    shutdown  = "sudo systemctl poweroff";     # Arrêt rapide
  };
}
