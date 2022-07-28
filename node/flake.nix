{
  description = "A Nix-flake-based Node.js development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        inherit (pkgs) mkShell;

        nodejs = pkgs.nodejs;
        pnpm = pkgs.nodePackages.pnpm;
        yarn = pkgs.yarn;

      in {
        devShells = {
          default = pkgs.mkShell {
            nativeBuildInputs = [
              nodejs
              pnpm
              (yarn.override { inherit nodejs; })
            ];

            shellHook = ''
              echo "node `${nodejs}/bin/node --version`"
            '';
          };
        };
      }
    );
}
