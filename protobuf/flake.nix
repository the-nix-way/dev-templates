{
  description = "A Nix-flake-based Protobuf development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) buf protobuf;
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ buf protobuf ];

            shellHook = ''
              echo "buf `${buf}/bin/buf --version`"
              ${protobuf}/bin/protoc --version
            '';
          };
        };
      });
}
