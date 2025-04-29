{
  description = "A Nix-flake-based OCaml development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f: nixpkgs.lib.genAttrs supportedSystems (system: f { pkgs = import nixpkgs { inherit system; }; });
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default =
            let
              ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_14;
            in
            pkgs.mkShell {
              packages = with ocamlPackages; [
                ocaml
                ocamlformat
                ocaml-lsp
                dune_3
                odoc
              ];
            };
        }
      );
    };
}
