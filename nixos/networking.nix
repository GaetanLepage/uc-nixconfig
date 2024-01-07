{hostname, ...}: {
  networking = {
    hostName = hostname;

    # Pick only one of the below networking options.
    wireless.enable = false;
    networkmanager.enable = true;

    firewall.enable = true;
  };
}
