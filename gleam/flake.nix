{
  description = "A Nix-flake-based Gleam development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        gleamPkg = pkgs.gleam;

        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ gleamPkg ];

            shellHook = ''
              ${gleamPkg}/bin/gleam --version
            '';
          };
        };
      });
}
