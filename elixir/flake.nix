{
  description = "A Nix-flake-based Elixir development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # unstable Nixpkgs

  outputs =
    { self, ... }@inputs:

    let
      inherit (inputs.nixpkgs) lib;

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forEachSupportedSystem =
        f:
        lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [ inputs.self.overlays.default ];
            };
          }
        );
    in
    {
      overlays.default =
        final: prev:
        let
          # documentation
          # https://nixos.org/manual/nixpkgs/stable/#sec-beam

          # ==== ERLANG / BEAM packages ====

          # use whatever OTP version is currently the default in nixpkgs
          # pkgs-beam = final.beamPackages;

          # use latest version of Erlang/OTP 28; all BEAM packages are compiled with it
          # (use e.g. `final.beam27Packages` for a different OTP version, and
          # `.overrideScope` to change any of its members)
          pkgs-beam = final.beam28Packages;
        in
        {
          # ==== Elixir ====

          # use whatever version is currently defined in nixpkgs
          # elixir = pkgs-beam.elixir;

          # use latest version of Elixir 1.19
          elixir = pkgs-beam.elixir_1_19;

          # specify exact version of Elixir
          # elixir = pkgs-beam.elixir.override {
          #   version = "1.17.1";
          #   sha256 = "sha256-a7A+426uuo3bUjggkglY1lqHmSbZNpjPaFpQUXYtW9k=";
          # };
        };

      devShells = forEachSupportedSystem (
        { pkgs, system }:
        {
          default = pkgs.mkShellNoCC {
            packages =
              with pkgs;
              [
                # use the Elixr/OTP versions defined above; will also install OTP, mix, hex, rebar3
                elixir

                # mix needs it for downloading dependencies
                git

                # probably needed for your Phoenix assets
                nodejs_latest

                self.formatter.${system}
              ]
              ++
                # Linux only
                pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux (
                  with pkgs;
                  [
                    gigalixir
                    inotify-tools
                    libnotify
                  ]
                )
              ++
                # macOS only
                pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin (
                  with pkgs;
                  [
                    terminal-notifier
                  ]
                );
          };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt-tree);
    };
}
