{
  description = "A Nix-flake-based Dhall development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
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
        dhallToolsLinux =
          optionals isLinux (mkDhallTools [ "csv" "haskell" "text" ]);

        dhallTools = dhallToolsCommon ++ dhallToolsLinux;
      in {
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
