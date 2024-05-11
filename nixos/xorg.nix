{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;

      # Configure keymap
      xkb.layout = "fr";

      # Gnome
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
        wayland = true;
      };

      desktopManager.gnome.enable = true;
    };

    displayManager = {
      # Force wayland session by default
      defaultSession = "gnome";
      autoLogin = {
        enable = true;
        user = "uc";
      };
    };
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
