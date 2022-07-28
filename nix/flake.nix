{
  description = "A Nix-flake-based Zig development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        nix = pkgs.nixUnstable;

        helpers = with pkgs; [ nixfmt nixpkgs-fmt statix ];

        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ nix ] ++ helpers;

            shellHook = ''
              ${nix}/bin/nix --version
            '';
          };
        };
      });
}
