{
  description = "A Nix-flake-based Node.js development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        nodeOverlay = self: super: rec {
          nodejs = super.nodejs-18_x;
          pnpm = super.nodePackages.pnpm;
          yarn = (super.yarn.override { inherit nodejs; });
        };
        overlays = [ nodeOverlay ];
        pkgs = import nixpkgs { inherit overlays system; };
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ node2nix nodejs pnpm yarn ];

            shellHook = ''
              echo "node `${pkgs.nodejs}/bin/node --version`"
            '';
          };
        };
      });
}
