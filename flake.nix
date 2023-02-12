{
    description = "Server configuration";


    inputs = {
        nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
        simple-nixos-mailserver.url = gitlab:simple-nixos-mailserver/nixos-mailserver;
        agenix.url = github:ryantm/agenix;
    };


    outputs = {
        self,
        nixpkgs,
        simple-nixos-mailserver,
        agenix
    }:

    let
        system = "x86_64-linux";

    in {

        # System configuration
        nixosConfigurations = {

            server = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./nixos/server
                    simple-nixos-mailserver.nixosModule {
                        imports = [ ./nixos/server/mailserver.nix ];
                    }
                    agenix.nixosModules.default
                ];
            };

            backup = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [ ./nixos/backup ];
            };
        };

    };
}
