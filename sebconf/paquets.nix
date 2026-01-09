{ pkgs, ... }:
{
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.kdePackages.xdg-desktop-portal-kde ];
  xdg.portal.config.common.default = "kde";
  xdg.portal.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    requires = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && flatpak install -y flathub org.dupot.easyflatpak
    '';
  };

  environment.systemPackages = with pkgs;[
   # APP
   amule
   #appimage-run
   aspell
   aspellDicts.fr
   bashFHS
   bluez-tools
   btop-cuda
   cataclysm-dda
   detox
   dgen-sdl
   discord
   enchant
   fastfetch
   fceux
   filezilla
   flare
   gimp
   git
   glaxnimate
   gparted
   gspell
   simple-scan
   humanity-icon-theme
   hunspell
   hunspellDicts.fr-any
   ispell
   lftp
   libreoffice-fresh
   mc
   mesa-demos
   luanti #minetest
   mldonkey
   mplayer
   mpv
   nestopia-ue
   nodejs_22
   ntfs3g
   obs-studio
   p7zip
   pciutils
   pitivi
   qbittorrent
   quodlibet
   retroarch-full
   rocksndiamonds
   screen
   scummvm
   smplayer
   soundconverter
   sound-juicer
   the-legend-of-edgar
   typora
   usbutils
   ubuntu-classic
   vivaldi
   vivaldi-ffmpeg-codecs
   vlc
   wesnoth
   wget
   #wineWowPackages.staging #dans gaming.nix
   #vscode-with-extensions
   vscode-fhs
   yaru-theme
   yt-dlp
   zeroad-unwrapped
   zola
  ];
} 
