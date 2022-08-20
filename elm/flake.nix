{
  description = "A Nix-flake-based Elm development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;

        elm = pkgs.elmPackages.elm;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ elm ] ++ (with pkgs; [ elm2nix ]);

            shellHook = ''
              echo "elm `${elm}/bin/elm --version`"
            '';
          };
        };
      });
}
