{
  description =
    "Ready-made templates for easily creating flake-driven environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    {
      templates = rec {
        clojure = {
          path = ./clojure;
          description = "Clojure development environment";
        };

        cue = {
          path = ./cue;
          description = "Cue development environment";
        };

        dhall = {
          path = ./dhall;
          description = "Dhall development environment";
        };

        elixir = {
          path = ./elixir;
          description = "Elixir development environment";
        };

        elm = {
          path = ./elm;
          description = "Elm development environment";
        };

        gleam = {
          path = ./gleam;
          description = "Gleam development environment";
        };

        go = {
          path = ./go;
          description = "Go (Golang) development environment";
        };

        hashi = {
          path = ./hashi;
          description = "HashiCorp DevOps tools development environment";
        };

        haskell = {
          path = ./haskell;
          description = "Haskell development environment";
        };

        java = {
          path = ./java;
          description = "Java development environment";
        };

        kotlin = {
          path = ./kotlin;
          description = "Kotlin development environment";
        };

        nickel = {
          path = ./nickel;
          description = "Nickel development environment";
        };

        nim = {
          path = ./nim;
          description = "Nim development environment";
        };

        nix = {
          path = ./nix;
          description = "Nix development environment";
        };

        node = {
          path = ./node;
          description = "Node.js development environment";
        };

        opa = {
          path = ./opa;
          description = "Open Policy Agent development environment";
        };

        php = {
          path = ./php;
          description = "PHP development environment";
        };

        protobuf = {
          path = ./protobuf;
          description = "Protobuf development environment";
        };

        python = {
          path = ./python;
          description = "Python development environment";
        };

        ruby = {
          path = ./ruby;
          description = "Ruby development environment";
        };

        rust = {
          path = ./rust;
          description = "Rust development environment";
        };

        rust-toolchain = {
          path = ./rust-toolchain;
          description = "Rust development environment with Rust version defined by a rust-toolchain.toml file";
        };

        scala = {
          path = ./scala;
          description = "Scala development environment";
        };

        zig = {
          path = ./zig;
          description = "Zig development environment";
        };

        # Aliases
        rt = rust-toolchain;
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell writeScriptBin;
        exec = pkg: "${pkgs.${pkg}}/bin/${pkg}";

        format = writeScriptBin "format" ''
          ${exec "nixpkgs-fmt"} **/*.nix
        '';

        dvt = writeScriptBin "dvt" ''
          if [ -z $1 ]; then
            echo "no template specified"
            exit 1
          fi

          TEMPLATE=$1

          ${exec "nix"} \
            --experimental-features 'nix-command flakes' \
            flake init \
            --template \
            "github:the-nix-way/dev-templates#''${TEMPLATE}"
        '';

        update = writeScriptBin "update" ''
          for dir in `ls -d */`; do # Iterate through all the templates
            (
              cd $dir
              ${exec "nix"} flake update # Update flake.lock
              ${exec "direnv"} reload    # Make sure things work after the update
            )
          done
        '';
      in
      {
        devShells = { default = mkShell { buildInputs = [ format update ]; }; };

        packages = rec {
          default = dvt;

          inherit dvt;
        };
      });
}
