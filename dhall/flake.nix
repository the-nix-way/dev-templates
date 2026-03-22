{
  description = "A Nix-flake-based Dhall development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # unstable Nixpkgs

  outputs =
    { self, ... }@inputs:

    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs, system }:
        {
          default =
            let
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
            in
            pkgs.mkShellNoCC {
              packages =
                (with pkgs; [
                  dhall
                  self.formatter.${system}
                ])
                ++ dhallTools;
            };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);
    };
}
