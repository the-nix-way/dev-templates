{
  description = "A Nix-flake-based Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , rust-overlay
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [
        (import rust-overlay)
        (self: super: {
          rustToolchain =
            let
              rust = super.rust-bin;
              toolchain =
                if builtins.pathExists ./rust-toolchain.toml then
                  rust.fromRustupToolchainFile ./rust-toolchain.toml
                else if builtins.pathExists ./rust-toolchain then
                  rust.fromRustupToolchainFile ./rust-toolchain
                else
                  rust.stable.latest.default;
            in
            toolchain.override {
              extensions = [ "rust-src" ]; # https://github.com/the-nix-way/dev-templates/issues/4
            };
        })
      ];

      pkgs = import nixpkgs { inherit system overlays; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          rustToolchain
          openssl
          pkg-config
          cargo-deny
          cargo-edit
          cargo-watch
          rust-analyzer
          evcxr
        ];

        shellHook = ''
          ${pkgs.rustToolchain}/bin/cargo --version
        '';
      };
    });
}
