{pkgs, ...}: {
  services.xserver = {
    enable = true;

    # Configure keymap
    layout = "fr";

    # Gnome
    displayManager = {
      gdm = {
        enable = true;
        autoSuspend = false;
        wayland = true;
      };
      # Force wayland session by default
      defaultSession = "gnome";
      autoLogin = {
        enable = true;
        user = "uc";
      };
    };

    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs.gnomeExtensions; [
    dash-to-dock
  ];
}
