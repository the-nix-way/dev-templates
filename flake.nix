{
  description = "Ready-made templates for easily creating flake-driven environments";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";

  outputs =
    { self, ... }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs, system }:
        {
          default =
            let
              getSystem = "SYSTEM=$(nix eval --impure --raw --expr 'builtins.currentSystem')";
              forEachDir = exec: ''
                for dir in */; do
                  (
                    cd "''${dir}"

                    ${exec}
                  )
                done
              '';

              script =
                name: runtimeInputs: text:
                pkgs.writeShellApplication {
                  inherit name runtimeInputs text;
                  bashOptions = [
                    "errexit"
                    "pipefail"
                  ];
                };
            in
            pkgs.mkShellNoCC {
              packages =
                with pkgs;
                [
                  (script "build" [ ] ''
                    ${getSystem}

                    ${forEachDir ''
                      echo "building ''${dir}"
                      nix build ".#devShells.''${SYSTEM}.default"
                    ''}
                  '')
                  (script "check" [ nixfmt ] (forEachDir ''
                    echo "checking ''${dir}"
                    nix flake check --all-systems --no-build
                  ''))
                  (script "format" [ nixfmt ] ''
                    git ls-files '*.nix' | xargs nix fmt
                  '')
                  (script "check-formatting" [ nixfmt ] ''
                    git ls-files '*.nix' | xargs nixfmt --check
                  '')
                ]
                ++ [ self.formatter.${system} ];
            };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);

      packages = forEachSupportedSystem (
        { pkgs, ... }:
        rec {
          default = dvt;
          dvt = pkgs.writeShellApplication {
            name = "dvt";
            bashOptions = [
              "errexit"
              "pipefail"
            ];
            text = ''
              if [ -z "''${1}" ]; then
                echo "no template specified"
                exit 1
              fi

              TEMPLATE=$1

              nix \
                --experimental-features 'nix-command flakes' \
                flake init \
                --template \
                "https://flakehub.com/f/the-nix-way/dev-templates/0.1#''${TEMPLATE}"
            '';
          };
        }
      );
    }

    //

      {
        templates = rec {
          default = empty;

          bun = {
            path = ./bun;
            description = "Bun development environment";
          };

          c-cpp = {
            path = ./c-cpp;
            description = "C/C++ development environment";
          };

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

          empty = {
            path = ./empty;
            description = "Empty dev template that you can customize at will";
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

          jupyter = {
            path = ./jupyter;
            description = "Jupyter development environment";
          };

          kotlin = {
            path = ./kotlin;
            description = "Kotlin development environment";
          };

          latex = {
            path = ./latex;
            description = "LaTeX development environment";
          };

          lean4 = {
            path = ./lean4;
            description = "Lean 4 development environment";
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

          ocaml = {
            path = ./ocaml;
            description = "OCaml development environment";
          };

          odin = {
            path = ./odin;
            description = "Odin development environment";
          };

          opa = {
            path = ./opa;
            description = "Open Policy Agent development environment";
          };

          php = {
            path = ./php;
            description = "PHP development environment";
          };

          platformio = {
            path = ./platformio;
            description = "PlatformIO development environment";
          };

          protobuf = {
            path = ./protobuf;
            description = "Protobuf development environment";
          };

          pulumi = {
            path = ./pulumi;
            description = "Pulumi development environment";
          };

          purescript = {
            path = ./purescript;
            description = "Purescript development environment";
          };

          python = {
            path = ./python;
            description = "Python development environment";
          };

          r = {
            path = ./r;
            description = "R development environment";
          };

          ruby = {
            path = ./ruby;
            description = "Ruby development environment";
          };

          rust = {
            path = ./rust;
            description = "Rust development environment";
          };

          scala = {
            path = ./scala;
            description = "Scala development environment";
          };

          shell = {
            path = ./shell;
            description = "Shell script development environment";
          };

          swi-prolog = {
            path = ./swi-prolog;
            description = "Swi-prolog development environment";
          };

          swift = {
            path = ./swift;
            description = "Swift development environment";
          };

          typst = {
            path = ./typst;
            description = "Typst development environment";
          };

          vlang = {
            path = ./vlang;
            description = "Vlang developent environment";
          };

          zig = {
            path = ./zig;
            description = "Zig development environment";
          };

          # Aliases
          c = c-cpp;
          cpp = c-cpp;
        };
      };
}
