{
  description = "A Nix-flake-based Haskell development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ cabal-install ghc ];

        shellHook = with pkgs; ''
          ${ghc}/bin/ghc --version
          ${cabal-install}/bin/cabal --version
        '';
      };
    });
}
