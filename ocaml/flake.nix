{
  description = "A Nix-flake-based OCaml development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;
        ocaml = pkgs.ocamlPackages.ocaml;
        ocamlTools = with pkgs.ocamlPackages;
          [ dune_3 odoc ] ++ (with pkgs; [ ocamlformat ]);
      in
      {
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
