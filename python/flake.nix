{
  description = "A Nix-flake-based Protobuf development environment";

  inputs = {
    dev.url = "github:the-nix-way/dev-templates";
    mach-nix.url = "github:/DavHau/mach-nix";
  };

  outputs = { self, dev, mach-nix }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;

        python = pkgs.python311;

        machNix = mach-nix.defaultPackage.${system};

        pythonTools = with pkgs;
          [ virtualenv ] ++ (with pkgs.python311Packages; [ pip ]);
        nixTools = [ machNix ];
      in {
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
