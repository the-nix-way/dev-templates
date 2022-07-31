{
  description = "A Nix-flake-based Nix development environment";

  inputs = {
    dev.url = "github:the-nix-way/dev-templates";
  };

  outputs = { self, dev }:
    let
      inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        nix = pkgs.nixUnstable;
        dhallNix = pkgs.haskellPackages.dhall-nix;

        nixRelatedTools = with pkgs; [
          cachix
          dhallNix
          lorri
          niv
          nixfmt
          nixpkgs-fmt
          statix
        ];

        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = mkShell { buildInputs = [ nix ] ++ nixRelatedTools; };
        };
      });
}
