{
  description = "Server configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
    flake-parts,
  } @ inputs: let
    hostname = "ultime-tv";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;

      flake = {
        nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [./nixos];
          specialArgs = {
            inherit hostname;
          };
        };
      };

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        packages.default = with pkgs;
          writeShellScriptBin "update" ''
            echo "=> Updating flake inputs"
            nix flake update

            echo "=> Updating system"
            nixos-rebuild switch \
                --verbose \
                --fast \
                --flake .#${hostname} \
                --target-host root@tv \
                --build-host root@tv
          '';

        formatter = pkgs.alejandra;
      };
    };
}
