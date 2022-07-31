{
  description =
    "A Nix-flake-based development environment for Terraform, Packer, and Nomad";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        inherit (pkgs)
          damon levant mkShell nomad nomad-autoscaler nomad-pack packer
          terraform;

        hashiTools =
          [ packer terraform nomad nomad-autoscaler nomad-pack levant damon ];

        relatedTools = with pkgs; [ terragrunt ];
      in {
        devShells = {
          default = mkShell {
            buildInputs = hashiTools ++ relatedTools;

            shellHook = ''
              echo "packer `${packer}/bin/packer --version`"
              ${terraform}/bin/terraform --version
              ${nomad}/bin/nomad --version
            '';
          };
        };
      });
}
