{
  description = "A Nix-flake-based Nix development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
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
      in {
        devShells = { default = mkShell { buildInputs = nixRelatedTools; }; };
      });
}
