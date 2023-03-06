{
  description =
    "A Nix-flake-based development environment for Terraform, Packer, and Nomad";

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
