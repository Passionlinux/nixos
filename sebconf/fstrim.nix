{
  services.fstrim = {
    enable = true;
    interval = "weekly";  # TRIM une fois par semaine, suffisant pour un SSD domestique
  };
}
