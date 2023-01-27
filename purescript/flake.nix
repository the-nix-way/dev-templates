{
  description = "A Nix-flake-based Purescript development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
    easy-purescript-nix = {
      url = "github:justinwoo/easy-purescript-nix";
      flake = false;
    };
  };
  outputs =
    { self
    , nixpkgs
    , flake-utils
    , easy-purescript-nix
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      easy-ps = import easy-purescript-nix { inherit pkgs; };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          easy-ps.purs
          easy-ps.spago
          easy-ps.purescript-language-server
          easy-ps.purs-tidy
          pkgs.nodejs
        ];
        shellHook = ''
          echo "Purs `${easy-ps.purs}/bin/purs --version`"
          echo "Spago `${easy-ps.spago}/bin/spago --version`"
          echo "Purescript Language Server `${easy-ps.purescript-language-server}/bin/purescript-language-server --version`"
          echo "Purs Tidy `${easy-ps.purs-tidy}/bin/purs-tidy --version`"
          echo "Node.js `${pkgs.nodejs}/bin/node --version`"
        '';
      };
    });
}
