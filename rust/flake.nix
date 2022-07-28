{
  description = "A Nix-flake-based Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          (import rust-overlay)
        ];

        pkgs = import nixpkgs {
          inherit system overlays;
        };

        rust = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;

        helpers = with pkgs; [ pkg-config ];

        inherit (pkgs) mkShell;
        inherit (pkgs.lib) optionals;
        inherit (pkgs.stdenv) isDarwin;
      in {
        packages.default = rust;

        devShells = {
          default = mkShell {
            nativeBuildInputs = [
              rust
            ] ++ helpers;

            buildInputs = with pkgs; [
              openssl
              pkgconfig
            ];

            shellHook = ''
              ${rust}/bin/cargo --version
            '';
          };
        };
      }
    );
}
