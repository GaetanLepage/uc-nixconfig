{
    description = "Server configuration";


    inputs.nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

    outputs = { self, nixpkgs }:
    {
        nixosConfigurations.server = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./nixos ];
        };
    };
}
