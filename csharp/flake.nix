{
  description = "A Nix-flake-based C# development environment";

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
          #dotnet-sdk_6
          dotnet-sdk_7
          #dotnet-sdk_8
          omnisharp-roslyn
          mono
          msbuild
        ];
      };
    });
}
