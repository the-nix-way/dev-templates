{
  description = "A Nix-flake-based Go 1.17 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      goVersion = 19;
      overlays = [ (self: super: { go = super."go_1_${toString goVersion}"; }) ];
      pkgs = import nixpkgs { inherit overlays system; };
    in
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          # go 1.19 (specified by overlay)
          go

          # goimports, godoc, etc.
          gotools

          # https://github.com/golangci/golangci-lint
          golangci-lint
        ];

        shellHook = ''
          ${pkgs.go}/bin/go version
        '';
      };
    });
}
