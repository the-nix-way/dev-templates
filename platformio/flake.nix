{
  description = "A Nix-flake-based PlatformIO development environment";

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
          default = pkgs.mkShellNoCC {
            packages =
              with pkgs;
              [
                clang-tools
                cmake
                codespell
                conan
                cppcheck
                doxygen
                gtest
                lcov
                platformio
                vcpkg
                vcpkg-tool
                self.formatter.${system}
              ]
              ++ pkgs.lib.optionals (stdenv.hostPlatform.system != "aarch64-darwin") [ gdb ];

            shellHook = ''
              export PLATFORMIO_CORE_DIR=$PWD/.platformio
            '';
          };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);
    };
}
