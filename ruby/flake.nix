{
  description = "A Nix-flake-based Ruby development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;

        ruby = pkgs.ruby_3_1;
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ ruby ];

            shellHook = ''
              ${ruby}/bin/ruby --version
            '';
          };
        };
      });
}
