{
  description = "A Nix-flake-based Pulumi development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";

  outputs =
    inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              # Pulumi plus:
              # pulumi-watch
              # pulumi-analyzer-* utilities
              # pulumi-language-* utilities
              # pulumi-resource-* utilities
              pulumi-bin

              # Python SDK
              python311

              # Go SDK
              go_1_23

              # Node.js SDK
              nodejs

              # Java SDK
              jdk
              maven

              # Kubernetes
              kubectl

              # Miscellaneous utilities
              jq
            ];
          };
        }
      );
    };
}
