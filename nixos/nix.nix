{
    nixpkgs.config.allowUnfree = true;

    # Enable flake support
    nix = {
        extraOptions = ''
            experimental-features = nix-command flakes

            warn-dirty = false
        '';

        # Garbage collection
        gc = {
            automatic = true;
            dates = "05:00";
            options = "--delete-older-than 4d";
        };
    };

    system.autoUpgrade = {
        enable = true;
        dates = "04:00";
        flake = github:GaetanLepage/uc-nixconfig;
        flags = [
            "--update-input" "nixpkgs"
            "--no-write-lock-file"
            "--option" "access-tokens" "github.com=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"
        ];
        allowReboot = true;
    };
}
