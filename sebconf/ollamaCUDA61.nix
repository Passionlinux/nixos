{ config, pkgs, lib, ... }:

let
  ollamaWithCUDA61 = pkgs.ollama-cuda.overrideAttrs (final: prev: {
    preBuild = (prev.preBuild or "") + ''
      cmake -B build -DCMAKE_CUDA_ARCHITECTURES="61"
      cmake --build build -j $NIX_BUILD_CORES
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    ollamaWithCUDA61
    oterm
  ];

  services.ollama = {
    enable = true;
    package = ollamaWithCUDA61;
    loadModels = [ "llama3.2" ];
    acceleration = "cuda";
  };
}

