{
  description = "A Nix-flake-based Protobuf development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
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
