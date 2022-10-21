{
  description = "A Nix-flake-based Ruby development environment";

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
        (self: super: {
          ruby = super.ruby_3_1;
        })
      ];
      pkgs = import nixpkgs { inherit overlays system; };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ ruby ];

        shellHook = ''
          ${pkgs.ruby}/bin/ruby --version
        '';
      };
    });
}
