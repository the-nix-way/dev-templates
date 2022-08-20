{
  description = "A Nix-flake-based Open Policy Agent development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) conftest mkShell open-policy-agent;

        opaTools = [ conftest open-policy-agent ];
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = opaTools;

            shellHook = ''
              ${open-policy-agent}/bin/opa version
            '';
          };
        };
      });
}
