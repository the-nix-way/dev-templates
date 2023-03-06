{
  description = "A Nix-flake-based Purescript development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
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
      pkgs = import nixpkgs { inherit system; };
      easy-ps = import easy-purescript-nix { inherit pkgs; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = (with pkgs; [ nodejs ]) ++ (with easy-ps; [
          purs
          spago
          purescript-language-server
          purs-tidy
        ]);

        shellHook = with easy-ps; ''
          echo "Purs `${purs}/bin/purs --version`"
          echo "Spago `${spago}/bin/spago --version`"
          echo "Purescript Language Server `${purescript-language-server}/bin/purescript-language-server --version`"
          echo "Purs Tidy `${purs-tidy}/bin/purs-tidy --version`"
          echo "Node.js `${pkgs.nodejs}/bin/node --version`"
        '';
      };
    });
}
