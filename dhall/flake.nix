{
  description = "A Nix-flake-based Dhall development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        dhall = pkgs.dhall;

        inherit (pkgs.lib) optionals;
        inherit (pkgs.stdenv) isLinux;

        # Helper function for building dhall-* tools
        mkDhallTools = ls: builtins.map (tool: pkgs.haskellPackages."dhall-${tool}") ls;

        dhallTools = mkDhallTools [
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
        dhallToolsLinux = mkDhallTools [
          "csv"
          "haskell"
          "text"
        ];

        otherFormats = dhallTools ++ optionals isLinux dhallToolsLinux;

        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ dhall ] ++ otherFormats;

            shellHook = ''
              echo "dhall `${dhall}/bin/dhall --version`"
            '';
          };
        };
      });
}
