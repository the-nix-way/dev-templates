{
  description = "A Nix-flake-based Go 1.17 development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        goPkg = pkgs.go_1_17;

        inherit (pkgs) mkShellNoCC;
      in {
        apps.default = {
          type = "app";
          program = "${goPkg}/bin/go";
        };

        devShells = {
          default = mkShellNoCC {
            buildInputs = with pkgs; [
              # go 1.17.1
              goPkg

              # goimports, godoc, etc.
              gotools

              # https://github.com/golangci/golangci-lint
              golangci-lint
            ];

            shellHook = ''
              ${goPkg}/bin/go version
            '';
          };
        };
      });
}
