{
  description = "A startup rust project with devshell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.pre-commit-hooks.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.rust-overlay.overlays.default
              (_final: prev: {
                rustToolchain =
                  let
                    rust = prev.rust-bin;
                  in
                  if builtins.pathExists ./rust-toolchain.toml then
                    rust.fromRustupToolchainFile ./rust-toolchain.toml
                  else if builtins.pathExists ./rust-toolchain then
                    rust.fromRustupToolchainFile ./rust-toolchain
                  else
                    rust.stable.latest.default.override {
                      extensions = [
                        "rust-src"
                        "rust-analyzer"
                      ];
                      # targets = [ "arm-unknown-linux-gnueabihf" ];
                    };
              })
            ];
          };

          # https://flake.parts/options/treefmt-nix.html
          # Example: https://github.com/nix-community/buildbot-nix/blob/main/nix/treefmt/flake-module.nix
          treefmt = {
            projectRootFile = "flake.nix";
            settings.global.excludes = [ ];

            programs = {
              deadnix.enable = true;
              nixfmt.enable = true;
              rustfmt.enable = true;
              # shellcheck.enable = true;
              # shfmt.enable = true;
              statix.enable = true;
              prettier = {
                enable = true;
                # Use Prettier 2.x for CJK pangu formatting
                package = pkgs.nodePackages.prettier.override {
                  version = "2.8.8";
                  src = pkgs.fetchurl {
                    url = "https://registry.npmjs.org/prettier/-/prettier-2.8.8.tgz";
                    sha512 = "tdN8qQGvNjw4CHbY+XXk0JgCXn9QiF21a55rBe5LJAU+kDyC4WQn4+awm2Xfk2lQMk5fKup9XgzTZtGkjBdP9Q==";
                  };
                };
                settings.editorconfig = true;
              };
            };
          };

          # https://flake.parts/options/git-hooks-nix.html
          # Example: https://github.com/cachix/git-hooks.nix/blob/master/template/flake.nix
          pre-commit.settings.hooks = {
            /*
              clippy = {
                enable = true;
                packageOverrides = {
                  cargo = pkgs.rustToolchain;
                  clippy = pkgs.rustToolchain;
                };
                settings = {
                  allFeatures = true;
                  denyWarnings = true;
                };
              };
            */
            commitizen.enable = true;
            eclint.enable = true;
            editorconfig-checker.enable = true;
            treefmt.enable = true;
          };

          devShells.default = pkgs.mkShell {
            shellHook = ''
              ${config.pre-commit.installationScript}
              echo 1>&2 "Welcome to the development shell!"
            '';
            packages =
              with pkgs;
              [
                # Rust toolchain
                rustToolchain

                # Miscellaneous
                just
                cargo-audit
                cargo-bloat
                cargo-license
                cargo-llvm-cov
                cargo-nextest
                cargo-outdated
                cargo-show-asm
                samply
                valgrind
                watchexec
                bacon
              ]
              ++ config.pre-commit.settings.enabledPackages;
          };
        };
    };
}
