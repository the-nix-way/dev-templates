{
  description = "A Nix-flake-based Nix development environment";

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
      devShell = {
        buildInputs = with pkgs; [
          cachix
          lorri
          niv
          nixfmt
          statix
          vulnix
          haskellPackages.dhall-nix
        ];
      };
    });
}
