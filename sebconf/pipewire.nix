{ pkgs, ... }:

{
  services.pulseaudio.enable = false;
  # Priorité temps réel pour éviter les micro-coupures
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Utilisation de Wireplumber (le gestionnaire de sessions moderne)
    wireplumber.enable = true;

    # Configuration pour réduire la latence
    extraConfig.pipewire = {
      "99-lowlatency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 2048;
        };
      };
    };

    # règle pour désactiver la caméra
    wireplumber.extraConfig = {
      "10-disable-camera" = {
        "wireplumber.profiles" = {
          main = { "monitor.libcamera" = "disabled"; };
        };
      };
    };
  };

  # --- Bonus : Suppression du bruit pour le micro ---
  # Très utile si les ventilos tournent fort pendant le jeu ou que Ollama tourne
  programs.noisetorch.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol # L'interface indispensable pour gérer les sorties
    helvum      # Un patchbay graphique pour relier tes flux audio (style JACK)
  ];
}
