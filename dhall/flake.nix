{
  description = "A Nix-flake-based Dhall development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        dhall = pkgs.dhall;

        inherit (pkgs) mkShell;
        inherit (pkgs.lib) optionals;
        inherit (pkgs.stdenv) isLinux;

        # Helper function for building dhall-* tools
        mkDhallTools = ls:
          builtins.map (tool: pkgs.haskellPackages."dhall-${tool}") ls;

        # dhall-* tools available only on all platforms
        dhallToolsCommon = mkDhallTools [
          "bash"
          "docs"
          "json"
          "lsp-server"
          "nix"
          "nixpkgs"
          "openapi"
          "toml"
          "yaml"
        ];

        # dhall-* tools available only on Linux
        dhallToolsLinux = optionals isLinux (mkDhallTools [ "csv" "text" ]);

        dhallTools = dhallToolsCommon ++ dhallToolsLinux;
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ dhall ] ++ dhallTools;

            shellHook = ''
              echo "dhall `${dhall}/bin/dhall --version`"
            '';
          };
        };
      });
}
