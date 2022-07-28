{
  description = "A Nix-flake-based Dhall development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        dhall = pkgs.dhall;

        inherit (pkgs.lib) optionals;
        inherit (pkgs.stdenv) isLinux;

        otherFormats = with pkgs.haskellPackages; [
          dhall-bash
          dhall-docs
          dhall-lsp-server
          dhall-nix
          dhall-json
          dhall-toml
          dhall-yaml
        ] ++ optionals isLinux (with pkgs.haskellPackages; [ dhall-csv dhall-haskell ]);

        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ dhall ] ++ otherFormats;

            shellHook = ''
              echo "dhall `${dhall}/bin/dhall --version`"
            '';
          };
        };
      });
}
