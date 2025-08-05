{ config, pkgs, lib, ... }:
{
services.ollama.package = pkgs.ollama-cuda;
#services.ollama.port = "11434";
#services.ollama.home = "/var/lib/ollama";
#services.ollama.host = "127.0.0.1";
services.ollama.enable = true;
services.ollama.loadModels = [ "llama3.2" ];
services.ollama.openFirewall = true;
services.ollama.group = "ollama";
services.ollama.user = "ollama";
services.ollama.acceleration = "cuda";

}
