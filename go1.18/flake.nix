{
  description = "A Nix-flake-based Go 1.18 development environment";

  inputs = {
    dev.url = "github:the-nix-way/dev-templates";
  };

  outputs = { self, dev }:
    let
      inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        goPkg = pkgs.go_1_18;

        inherit (pkgs) mkShellNoCC;
      in {
        apps.default = {
          type = "app";
          program = "${goPkg}/bin/go";
        };

        devShells = {
          default = mkShellNoCC {
            buildInputs = with pkgs; [
              # go 1.18.3
              goPkg

              # goimports, godoc, etc.
              gotools

              # https://github.com/golangci/golangci-lint
              golangci-lint

              # The Go language server (for IDEs and such)
              gopls

              # https://pkg.go.dev/github.com/ramya-rao-a/go-outline
              go-outline

              # https://github.com/uudashr/gopkgs
              gopkgs
            ];

            shellHook = ''
              ${goPkg}/bin/go version
            '';
          };
        };
      });
}
