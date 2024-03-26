{
  description = "TV computer configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    devshell,
  } @ inputs: let
    hostname = "ultime-tv";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;

      imports = [
        inputs.devshell.flakeModule
      ];

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
        devshells.default = {
          packages = [
            pkgs.wol
          ];

          commands = [
            {
              name = "wake";
              command = "wol 90:1b:0e:57:34:a9 -h glepage.com -p 9";
            }
            {
              name = "deploy";
              command = ''
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
            }
          ];
        };

        formatter = pkgs.alejandra;
      };
    };
}
