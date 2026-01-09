{ config, pkgs, lib, ... }:
{
services.hardware.openrgb.package = pkgs.openrgb-with-all-plugins;
#services.hardware.openrgb.server.port = "6742";
services.hardware.openrgb.enable = true;
}
