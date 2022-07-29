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
        overlays = [ (import rust-overlay) ];

        pkgs = import nixpkgs { inherit system overlays; };
        inherit (pkgs) rust-bin;

        rust = if builtins.pathExists ./rust-toolchain.toml then
          rust-bin.fromRustupToolchainFile ./rust-toolchain.toml
        else if builtins.pathExists ./rust-toolchain then
          rust-bin.fromRustupToolchainFile ./rust-toolchain
        else
          rust-bin.stable.latest.default;

        helpers = with pkgs; [ openssl pkgconfig ];

        inherit (pkgs) mkShell;
        inherit (pkgs.lib) optionals;
        inherit (pkgs.stdenv) isDarwin;
      in {
        packages.default = rust;

        devShells = {
          default = mkShell {
            nativeBuildInputs = [ rust ];

            buildInputs = helpers;

            shellHook = ''
              ${rust}/bin/cargo --version
            '';
          };
        };
      });
}
