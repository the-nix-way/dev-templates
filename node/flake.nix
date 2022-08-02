{
  description = "A Nix-flake-based Node.js development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        inherit (pkgs) mkShell node2nix;

        nodejs = pkgs.nodejs-18_x;
        pnpm = pkgs.nodePackages.pnpm;
        yarn = (pkgs.yarn.override { inherit nodejs; });
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ node2nix nodejs pnpm yarn ];

            shellHook = ''
              echo "node `${nodejs}/bin/node --version`"
            '';
          };
        };
      });
}
