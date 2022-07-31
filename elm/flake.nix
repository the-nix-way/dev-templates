{
  description = "A Nix-flake-based Elm development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;

        elm = pkgs.elmPackages.elm;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ elm ] ++ (with pkgs; [ elm2nix ]);

            shellHook = ''
              echo "elm `${elm}/bin/elm --version`"
            '';
          };
        };
      });
}
