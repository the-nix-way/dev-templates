{
  description = "A Nix-flake-based PHP development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [
        (self: super: rec {
          php = super.php;
          composer = super.phpPackages.composer;
        })
      ];
      pkgs = import nixpkgs { inherit overlays system; };
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [ composer php ];

        shellHook = ''
          echo "`${pkgs.php}/bin/php --version`"
        '';
      };
    });
}
