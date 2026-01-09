{ config, pkgs, lib, ... }:

{
  #########################
  # Bluetooth minimal et propre
  #########################

  # Activer le support Bluetooth
  hardware.bluetooth.enable = true;

  # Laisser le paquet BlueZ par défaut
  # hardware.bluetooth.package = [ pkgs.bluez ];

  # Ne pas activer Blueman (KDE Plasma gère déjà le Bluetooth)
  services.blueman.enable = false; #true pour XFCE

  # Ne pas allumer le Bluetooth au boot
  hardware.bluetooth.powerOnBoot = false;
}
