{
  description = "A Nix-flake-based Haskell development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) cabal-install ghc mkShell;
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ cabal-install ghc ];

            shellHook = ''
              ${ghc}/bin/ghc --version
              ${cabal-install}/bin/cabal --version
            '';
          };
        };
      });
}
