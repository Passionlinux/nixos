{ config, pkgs, ... }:

{
  ############################################
  # Fail2ban – Protection contre le bruteforce
  ############################################
  services.fail2ban = {
    enable = true;  # Active Fail2ban

    # -------------------------------
    # Paramètres globaux (DEFAULT)
    # -------------------------------

    maxretry = 5;      # Nombre d'échecs avant bannissement
    bantime  = "1h";   # Durée du bannissement initial si non précisé dans la jail

    # -------------------------------
    # Bannissement progressif
    # -------------------------------

    bantime-increment = {
      enable = true;                        # Active la récidive intelligente
      multipliers = "1 2 4 8 16 32 64";     # Chaque récidive = ban plus long
      maxtime = "168h";                     # Jamais plus d'1 semaine
      overalljails = true;                  # Récidive globale (toutes jails confondues)
    };

    # -------------------------------
    # IPs ignorées (whitelist)
    # -------------------------------

    ignoreIP = [
      "127.0.0.1/8"       # Loopback IPv4
      "::1"               # Loopback IPv6
      "192.168.1.0/24"    # Réseau local
    ];

    # -------------------------------
    # Intégration firewall (Nix-style)
    # -------------------------------

    packageFirewall = config.networking.firewall.package;

    # -------------------------------
    # Jails (syntaxe moderne)
    # -------------------------------

    jails = {

      # ---- SSH : protection principale ----
      sshd.settings = {
        enabled  = true;           # Active la jail
        filter   = "sshd";         # Filtre Fail2ban standard
        backend  = "systemd";      # Lecture directe du journal systemd
        maxretry = 3;              # SSH = tolérance basse
        bantime  = "6h";           # Ban sérieux pour bruteforce
        findtime = "10m";          # Fenêtre pour compter les échecs
      };

      # ---- Recidive : punition longue durée ----
      recidive.settings = {
        enabled  = true;                  # Active la jail récidive
        filter   = "recidive";            # Jail spéciale multi-bans
        backend  = "systemd";
        maxretry = 5;                     # 5 bans = sanction lourde
        findtime = "24h";                 # Fenêtre large (historique)
        bantime  = "7d";                  # Une semaine dehors
      };
    };
  };

  ############################################
  # Durcissement SSH (complément indispensable)
  ############################################
  services.openssh = {
    enable = true;                       # SSH actif pour Fail2ban
    settings = {
      LogLevel = "VERBOSE";              # Logs détaillés pour Fail2ban
      PermitRootLogin = "no";            # Root interdit
      PasswordAuthentication = true;     # Clés uniquement = false
      KbdInteractiveAuthentication = false;
      MaxAuthTries = 3;                  # Cohérent avec Fail2ban
    };
  };

  ############################################
  # Pare-feu NixOS
  ############################################
  networking.firewall = {
    enable = true;                        # Pare-feu actif
    allowPing = false;                    # Pas de ping (discrétion)
    logRefusedConnections = true;         # Logs utiles en audit
  };
}
