{
  description = "A Nix-flake-based Open Policy Agent development environment";

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
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ open-policy-agent conftest ];

        shellHook = ''
          ${pkgs.open-policy-agent}/bin/opa version
        '';
      };
    });
}
