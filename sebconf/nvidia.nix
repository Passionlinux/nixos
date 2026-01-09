{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true; # installe l'outil nvidia-settings
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit  # Facultatif
    nvidia-vaapi-driver       # Ajoute le driver VA-API pour le décodage vidéo
    vdpauinfo                 # Outil pour tester VDPAU
    libva-utils               # Outils pour tester VA-API
    nvtopPackages.nvidia      # htop mais pour ton GPU !
  ];

  environment.sessionVariables = {
    # Indispensable pour l'accélération vidéo matérielle via nvidia-vaapi-driver
    NVD_BACKEND = "direct";
    # Pour forcer l'utilisation de la librairie d'accélération matérielle
    LIBVA_DRIVER_NAME = "nvidia";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver               # Pont VA-API → VDPAU
      libvdpau-va-gl            # Accélération VDPAU OpenGL
    ];
  };

  boot.extraModprobeConfig = ''
    options nvidia-drm modeset=1
  '';
}

