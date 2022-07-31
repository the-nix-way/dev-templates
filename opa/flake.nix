{
  description = "A Nix-flake-based Protobuf development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) conftest mkShell open-policy-agent;

        opaTools = [ conftest open-policy-agent ];
      in {
        devShells = {
          default = mkShell {
            buildInputs = opaTools;

            shellHook = ''
              ${open-policy-agent}/bin/opa version
            '';
          };
        };
      });
}
