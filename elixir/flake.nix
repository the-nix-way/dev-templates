{
  description = "A Nix-flake-based Elixir development environment";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};

      # documentation
      # https://nixos.org/manual/nixpkgs/stable/#sec-beam

      # ==== ERLANG ====

      # use whatever version is currently defined in nixpkgs
      erlang = pkgs.beam.interpreters.erlang;

      # use latest version of Erlang 26
      # erlang = pkgs.beam.interpreters.erlang_26;

      # specify exact version of Erlang OTP
      # erlang = pkgs.beam.interpreters.erlang.override {
      #   version = "26.2.2";
      #   sha256 = "sha256-7S+mC4pDcbXyhW2r5y8+VcX9JQXq5iEUJZiFmgVMPZ0=";
      # }

      # ==== BEAM packages ====

      # all BEAM packages will be compile with your preffered erlang version
      pkgs-beam = pkgs.beam.packagesWith erlang;

      # ==== Elixir ====

      # use whatever version is currently defined in nixpkgs
      elixir = pkgs-beam.elixir;

      # use latest version of Elixir 1.16
      # elixir = pkgs-beam.elixir_1_16;

      # specify exact version of Elixir
      # elixir = pkgs-beam.elixir.override {
      #   version = "1.16.1";
      #   sha256 = "sha256-rjUt3gCUszCbzGE7BriwH3ptrV81dqNB/d0nVOXrcGI=";
      # };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          # use the Elixr/OTP versions defined above; will also install OTP, mix, hex, rebar3
          elixir

          # mix needs it for downloading dependencies
          pkgs.git

          # probably needed for your Phoenix assets
          pkgs.nodejs_20
        ] ++
        # Linux only
        pkgs.lib.optionals pkgs.stdenv.isLinux (with pkgs; [ gigalixir inotify-tools libnotify ]) ++
        # macOS only
        pkgs.lib.optionals pkgs.stdenv.isDarwin (with pkgs.darwin.apple_sdk.frameworks; [ pkgs.terminal-notifier CoreFoundation CoreServices ]);

        # some sane defaults for iex session
        shellHooks = ''
          export ERL_AFLAGS="+pc unicode -kernel shell_history enabled"
          export ELIXIR_ERL_OPTIONS="+sssdio 128"
        '';
      };
    }
  );
}
