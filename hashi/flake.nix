{
  description =
    "A Nix-flake-based development environment for Terraform, Packer, and Nomad";

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
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          packer
          terraform
          tflint
          nomad
          vault
          nomad-autoscaler
          nomad-pack
          levant
          damon
          terragrunt
        ];

        shellHook = with pkgs; ''
          echo "packer `${packer}/bin/packer --version`"
          ${terraform}/bin/terraform --version
          ${nomad}/bin/nomad --version
          ${vault}/bin/vault --version
        '';
      };
    });
}
