{ pkgs, config, lib, ... }:
{
  # Boot & kernel
  boot = {
    # Nettoyage automatique du /tmp à chaque boot
    tmp.cleanOnBoot = true;

    # Désactivation de ZFS uniquement
    supportedFilesystems.zfs = lib.mkForce false; # Pas utilisé

    # Choix du noyau Zen pour meilleure réactivité et performance desktop/gaming
    # kernelPackages = pkgs.linuxPackages;
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelPackages = pkgs.linuxPackages_zen;

    # Paramètres du kernel optimisés gaming
    kernelParams = [
      "quiet"               # Boot silencieux
      "loglevel=3"          # Messages kernel limités
      "systemd.show_status=auto" # Cache les messages système réussis
      "rd.udev.log_level=3"      # Moins de bruit au chargement des dri
      "intel_pstate=active" # Gestion optimale du scaling CPU Intel
      "iommu=pt"            # Option utile si virtualisation (optionnel)
      "threadirqs"          # Priorité IRQ thread pour gaming/audio
      "mitigations=auto"    # Sécurité sans gros impact perf
    ];
  };

  services.thermald.enable = lib.mkDefault true;

  # ZRAM Swap – Gaming-ready & IA-proof 🐓💨
  zramSwap = {
    enable = true;           # active ZRAM
    algorithm = "zstd";      # compression rapide et efficace
    # Avec 32 Go, on peut même monter à 50% sans risque,
    # car ZRAM ne consomme que ce qu'il utilise réellement.
    memoryPercent = 25;      # utilise 25% de la RAM pour ZRAM (≈8 Go sur 32 Go)
    priority = 100;          # priorité haute pour passer avant le swap disque (si présent)
    # RAM normale prioritaire
  };

  boot.kernel.sysctl = {
    # --- Mémoire & swap ---
    "vm.swappiness" = 150;             # Très réactif avec ZRAM uniquement
    "vm.page-cluster" = 0;             # Optimise pour les accès ZRAM
    "vm.vfs_cache_pressure" = 50;      # garde les caches inode/dentry plus longtemps
    "vm.dirty_ratio" = 15;             # limite les écritures sales en RAM
    "vm.dirty_background_ratio" = 5;   # déclenche plus tôt l'écriture en arrière-plan
    "vm.max_map_count" = 2147483642;   # nécessaire pour certains jeux / moteurs / Vulkan

    # --- Réactivité desktop ---
    "kernel.sched_autogroup_enabled" = 1;  # améliore la réactivité des applis interactives
    "kernel.sched_migration_cost_ns" = 5000000; # réduit les migrations CPU inutiles

    # --- Réseau (latence plus faible) ---
    "net.core.default_qdisc" = "fq";   # file d’attente moderne, faible latence
    "net.ipv4.tcp_congestion_control" = "bbr"; # congestion TCP efficace et stable

    # --- Sécurité légère sans pénaliser ---
    "kernel.kptr_restrict" = 1;
    "kernel.dmesg_restrict" = 1;
  };

  # Pour utiliser BBR, il faut charger le module noyau correspondant
  boot.kernelModules = [ "tcp_bbr" ];
}
