{
  description = "A Nix-flake-based Nim development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell nim;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ nim ];

            shellHook = ''
              ${nim}/bin/nim --version
            '';
          };
        };
      });
}
