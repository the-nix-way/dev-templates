{
  description = "A Nix-flake-based Nix development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        dhallNix = pkgs.haskellPackages.dhall-nix;

        nixRelatedTools = with pkgs; [
          cachix
          dhallNix
          lorri
          niv
          nixfmt
          statix
          vulnix
        ];

        inherit (pkgs) mkShell;
      in
      {
        devShells = { default = mkShell { buildInputs = nixRelatedTools; }; };
      });
}
