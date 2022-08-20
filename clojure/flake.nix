{
  description = "A Nix-flake-based Clojure development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
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
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [ boot clojure leiningen ];

        shellHook = ''
          ${pkgs.clojure}/bin/clj --version
        '';
      };
    });
}
