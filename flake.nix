{
  description = "Ready-made templates for easily creating flake-driven environments";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f: nixpkgs.lib.genAttrs supportedSystems (system: f { pkgs = nixpkgs.legacyPackages.${system}; });

      scriptDrvs = forEachSupportedSystem (
        { pkgs }:
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
        in
        {
          format = pkgs.writeShellApplication {
            name = "format";
            runtimeInputs = with pkgs; [ nixfmt-rfc-style ];
            text = ''
              shopt -s globstar

              nixfmt -- **/*.nix
            '';
          };

          # only run this locally, as Actions will run out of disk space
          build = pkgs.writeShellApplication {
            name = "build";
            text = ''
              ${getSystem}

              ${forEachDir ''
                echo "building ''${dir}"
                nix build ".#devShells.''${SYSTEM}.default"
              ''}
            '';
          };

          check = pkgs.writeShellApplication {
            name = "check";
            text = forEachDir ''
              echo "checking ''${dir}"
              nix flake check --all-systems --no-build
            '';
          };

          update = pkgs.writeShellApplication {
            name = "update";
            text = forEachDir ''
              echo "updating ''${dir}"
              nix flake update
            '';
          };
        }
      );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages =
              with scriptDrvs.${pkgs.system};
              [
                build
                check
                format
                update
              ]
              ++ [ pkgs.nixfmt-rfc-style ];
          };
        }
      );

      packages = forEachSupportedSystem (
        { pkgs }:
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
                "github:the-nix-way/dev-templates#''${TEMPLATE}"
            '';
          };
        }
      );
    }

    //

      {
        templates = rec {
          c-cpp = {
            path = ./c-cpp;
            description = "C/C++ development environment";
          };

          java = {
            path = ./java;
            description = "Java development environment";
          };

          kotlin = {
            path = ./kotlin;
            description = "Kotlin development environment";
          };

          latex = {
            path = ./latex;
            description = "LaTeX development environment";
          };

          markdown = {
            path = ./markdown;
            description = "Markdown development environment";
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

          # Aliases
          c = c-cpp;
          cpp = c-cpp;
          cxx = c-cpp;
          md = markdown;
          js = node;
          nodejs = node;
          tex = latex;
        };
      };
}
