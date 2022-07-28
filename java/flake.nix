{
  description = "A Nix-flake-based Java development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        inherit (pkgs) mkShell;

        java = pkgs.jdk17;

        buildTools = with pkgs; [ ant gradle maven ];
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ java ] ++ buildTools;

            shellHook = ''
              ${java}/bin/java -version
            '';
          };
        };
      });
}
