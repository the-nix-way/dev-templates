{
  description = "A Nix-flake-based Zig development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        zigPkg = pkgs.zig;

        inherit (pkgs) mkShell;
      in {
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
