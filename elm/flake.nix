{
  description = "A Nix-flake-based Elm development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = (with pkgs.elmPackages; [ elm ]) ++ (with pkgs; [ elm2nix ]);

        shellHook = with pkgs.elmPackages; ''
          echo "elm `${elm}/bin/elm --version`"
        '';
      };
    });
}
