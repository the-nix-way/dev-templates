{
  description = "A Nix-flake-based Clojure development environment";

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
      javaVersion = 17;
      overlays = [
        (self: super: rec {
          jdk = super."jdk${toString javaVersion}";
          boot = super.boot.override {
            inherit jdk;
          };
          clojure = super.clojure.override {
            inherit jdk;
          };
          leiningen = super.leiningen.override {
            inherit jdk;
          };
        })
      ];
      pkgs = import nixpkgs { inherit overlays system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ boot clojure leiningen ];

        shellHook = ''
          ${pkgs.clojure}/bin/clj --version
        '';
      };
    });
}
