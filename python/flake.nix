{
  description = "A Nix-flake-based Python development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    mach-nix.url = "github:/DavHau/mach-nix";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, mach-nix, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;

        python = pkgs.python311;

        machNix = mach-nix.defaultPackage.${system};

        pythonTools = with pkgs;
          [ virtualenv ] ++ (with pkgs.python311Packages; [ pip ]);
        nixTools = [ machNix ];
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ python ] ++ pythonTools ++ nixTools;

            shellHook = ''
              ${python}/bin/python --version
            '';
          };
        };
      });
}
