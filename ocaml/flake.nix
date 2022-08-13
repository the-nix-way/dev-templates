{
  description = "A Nix-flake-based OCaml development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;
        ocaml = pkgs.ocamlPackages.ocaml;
        ocamlTools = with pkgs.ocamlPackages;
          [ dune_3 odoc ] ++ (with pkgs; [ ocamlformat ]);
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ ocaml ] ++ ocamlTools;

            shellHook = ''
              ${ocaml}/bin/ocaml --version
            '';
          };
        };
      });
}
