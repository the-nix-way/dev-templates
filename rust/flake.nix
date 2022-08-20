{
  description = "A Nix-flake-based Rust development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, flake-utils, nixpkgs, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];

        pkgs = import nixpkgs { inherit system overlays; };

        inherit (pkgs) mkShell rust-bin;
        inherit (pkgs.lib) optionals;
        inherit (pkgs.stdenv) isLinux;

        rust = if builtins.pathExists ./rust-toolchain.toml then
          rust-bin.fromRustupToolchainFile ./rust-toolchain.toml
        else if builtins.pathExists ./rust-toolchain then
          rust-bin.fromRustupToolchainFile ./rust-toolchain
        else
          rust-bin.stable.latest.default;

        deps = with pkgs; [ openssl pkgconfig ];
        rustTools = with pkgs;
          [ cargo-audit cargo-deny cargo-cross rust-analyzer ]
          ++ optionals isLinux (with pkgs; [ cargo-watch ]);
      in {
        packages.default = rust;

        devShells = {
          default = mkShell {
            nativeBuildInputs = [ rust ] ++ deps ++ rustTools;

            shellHook = ''
              ${rust}/bin/cargo --version
            '';
          };
        };
      });
}
