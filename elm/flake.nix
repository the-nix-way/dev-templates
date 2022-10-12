{
  description = "A Nix-flake-based Elm development environment";

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
        buildInputs = (with pkgs.elmPackages; [ elm ]) ++ (with pkgs; [ elm2nix ]);

        shellHook = with pkgs.elmPackages; ''
          echo "elm `${elm}/bin/elm --version`"
        '';
      };
    });
}
