{
  description = "Server configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.ultime-pc = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [./nixos];
    };

    formatter.${system} = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
