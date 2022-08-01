{
  description = "A Nix-flake-based Protobuf development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell nickel;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ nickel ];

            shellHook = ''
              ${nickel}/bin/nickel --version
            '';
          };
        };
      });
}
