{
  description = "A Nix-flake-based Zig development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        zigPkg = pkgs.zig;

        inherit (pkgs) mkShell;
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ zigPkg ];

            shellHook = ''
              echo "zig `${zigPkg}/bin/zig version`"
            '';
          };
        };
      });
}
