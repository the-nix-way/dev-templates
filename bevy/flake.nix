{
  inputs = {
    # Option to nixify the game
    naersk.url = "github:nix-community/naersk/master";

    # Useful utils
    utils.url = "github:numtide/flake-utils";

    # Nixpkgs itself
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # A rust overlay in case the user wants to switch to the unstable branch
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, naersk, fenix }:
    utils.lib.eachDefaultSystem (system:
      let
        # Overrding the overlays
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ fenix.overlays.default ];
        };

        # Setting up the rust toolchain
        toolchain = (pkgs.fenix.complete.withComponents [
          "cargo"
          "clippy"
          "rust-src"
          "rustc"
          "rustfmt"
        ]);

        # Utility definition for our particular toolchain
        naersk-lib = pkgs.callPackage naersk {
          cargo = toolchain;
          rustc = toolchain;
        };
      in {
        # This is the part that provides the game as a pacakge
        defaultPackage = naersk-lib.buildPackage { src = ./.; };
        devShell = pkgs.mkShell {
          # Make bevy see the shared libraries
          shellHook = ''
            export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
              with pkgs;
              lib.makeLibraryPath [
                alsa-lib
                udev
                pkg-config
                vulkan-loader
                xorg.libX11
                xorg.libXcursor
                xorg.libXi
                xorg.libxcb
                xorg.libXrandr # To use the x11 feature
                libxkbcommon
                wayland # To use the wayland feature
              ]
            }"'';
          nativeBuildInputs = [ toolchain ];
          buildInputs = with pkgs; [ rust-analyzer-nightly ];
          RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
        };
      });
}
