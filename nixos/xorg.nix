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

  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  environment.systemPackages = with pkgs.gnomeExtensions; [
    dash-to-dock
  ];
}
