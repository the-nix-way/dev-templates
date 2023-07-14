{
  description =
    "A Nix-flake-based development environment for Terraform, Packer, and Nomad";


  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
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
        };
      });
    };
}
