{
  description = "A Nix-flake-based Cue development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) cue mkShell;
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ cue ];

            shellHook = ''
              ${cue}/bin/cue version
            '';
          };
        };
      });
}
