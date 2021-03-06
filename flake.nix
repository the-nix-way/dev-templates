{
  description =
    "Ready-made templates for easily creating flake-driven environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;
        format = pkgs.writeScriptBin "format" ''
          ${pkgs.nixfmt}/bin/nixfmt **/*.nix
        '';
        update = pkgs.writeScriptBin "update" ''
          # Update root
          ${pkgs.nix}/bin/nix flake update

          for dir in `ls -d */`; do # Iterate through all the templates
            (
              cd $dir
              ${pkgs.nix}/bin/nix flake update # Update flake.lock
              ${pkgs.direnv}/bin/direnv reload    # Make sure things work after the update
            )
          done
        '';
      in {
        devShells = {
          default = mkShell {
            buildInputs = with pkgs; [ format update ];
          };
        };
      }
    ) // {
      templates = {
        dhall = {
          path = ./dhall;
          description = "Dhall development environment";
        };

        elixir = {
          path = ./elixir;
          description = "Elixir development environment";
        };

        gleam = {
          path = ./gleam;
          description = "Gleam development environment";
        };

        go1_17 = {
          path = ./go1.17;
          description = "Go 1.17 development environment";
        };

        go1_18 = {
          path = ./go1.18;
          description = "Go 1.18 development environment";
        };

        java = {
          path = ./java;
          description = "Java development environment";
        };

        kotlin = {
          path = ./kotlin;
          description = "Kotlin development environment";
        };

        nix = {
          path = ./nix;
          description = "Nix development environment";
        };

        node = {
          path = ./node;
          description = "Node.js development environment";
        };

        protobuf = {
          path = ./protobuf;
          description = "Protobuf development environment";
        };

        rust = {
          path = ./rust;
          description = "Rust development environment";
        };

        scala = {
          path = ./scala;
          description = "Scala development environment";
        };

        zig = {
          path = ./zig;
          description = "Zig development environment";
        };
      };
    };
}
