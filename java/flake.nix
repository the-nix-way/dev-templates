{
  description = "A Nix-flake-based Java development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        jdk = "jdk17";

        config = {
          packageOverrides = p: {
            gradle = (p.gradle.override { java = p.${jdk}; });
          };
        };

        pkgs = import nixpkgs { inherit config jdk system; };
        java = pkgs.${jdk};
        buildTools = with pkgs; [ ant gradle maven ];
        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ java ] ++ buildTools;

            shellHook = ''
              ${java}/bin/java -version
            '';
          };
        };
      });
}
