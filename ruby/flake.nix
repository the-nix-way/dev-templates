{
  description = "A Nix-flake-based Ruby development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;

        ruby = pkgs.ruby_3_1;
      in {
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
