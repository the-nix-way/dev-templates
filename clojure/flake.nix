{
  description = "A Nix-flake-based Clojure development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        jdk = "jdk17";

        config = {
          packageOverrides = p: {
            clojure = p.clojure.override { jdk = p.${jdk}; };
            leiningen = p.leiningen.override { jdk = p.${jdk}; };
          };
        };

        pkgs = import nixpkgs { inherit config system; };
        inherit (pkgs) clojure leiningen mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ clojure leiningen ];

            shellHook = ''
            '';
          };
        };
      });
}
