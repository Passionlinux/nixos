{
  lib,
  config,
  pkgs,
  ...
}:

{
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 25;
      priority = 5;
    };
}
