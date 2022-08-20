{
  description = "A Nix-flake-based Protobuf development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) buf mkShell protobuf;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ buf protobuf ];

            shellHook = ''
              echo "buf `${buf}/bin/buf --version`"
              ${protobuf}/bin/protoc --version
            '';
          };
        };
      });
}
