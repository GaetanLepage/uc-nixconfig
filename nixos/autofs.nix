{ pkgs, ... }:
{
    services.autofs = {
        enable = true;

        autoMaster = let
            mapConf = pkgs.writeText "autofs.mnt" ''
                movies \
                    -fstype=nfs4 \
                    192.168.1.3:/tank/share/movies
            '';

        in ''
            /mnt        ${mapConf}          --timeout 60
        '';
    };
}
