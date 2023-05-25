{
  description = "A Nix-flake-based C/C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          # FIXME split into 3 different profiles?
          stdenv
          clangStdenv
          gccStdenv

          clang
          llvmPackages_latest.bintools # lld https://matklad.github.io/2022/03/14/rpath-or-why-lld-doesnt-work-on-nixos.html

          lldb
          gdb

          valgrind

          # FIXME is this necessary? shouldn't be in stdenv?
          binutils
          coreutils
          util-linux

          pkg-config
          libtool

          automake
          autoconf

          cmake
          cmake-language-server

          ninja

          unzip # needed for doom emacs gdb support

          ccls
          #sourcekit-lsp
        ];
      };
    });
}
