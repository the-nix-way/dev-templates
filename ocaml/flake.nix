{
  description = "A Nix-flake-based OCaml development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ ocaml ocamlformat ] ++
          (with pkgs.ocamlPackages; [ dune_3 odoc ]);

        shellHook = ''
          ${pkgs.ocaml}/bin/ocaml --version
        '';
      };
    });
}
