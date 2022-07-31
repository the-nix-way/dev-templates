{
  description = "A Nix-flake-based Dhall development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) cue mkShell;
      in {
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
