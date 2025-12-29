{
  description = "A Nix-flake-based Haxe development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # unstable Nixpkgs

  outputs =
    { self, ... }@inputs:

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
          default = pkgs.mkShellNoCC {
            # WARN: As of 2025-12-28:
            #       `haxe_4_0` is explicitly used because
            #       `haxe` is an alias for `haxe_4_3`,
            #       which requires `mbedtls_2`, which has
            #       been marked as insecure. The build
            #       expression for Haxe has not been
            #       updated to handle this yet, so it fails
            #       to build. This can be changed in the
            #       future or by the user, such as through
            #       an override.
            packages = with pkgs; [ haxe_4_0 ];
          };
        }
      );
    };
}
