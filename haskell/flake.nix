{
  description = "A Nix-flake-based Haskell development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) cabal-install ghc mkShell;
      in {
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
