{
  description = "A Nix-flake-based PyTorch development environment";

  # CUDA binaries are cached by the community.
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        });
  in {
    devShells = forEachSupportedSystem ({pkgs}: let
      libs = [
        # PyTorch and Numpy depends on the following libraries.
        pkgs.cudaPackages.cudatoolkit
        pkgs.cudaPackages.cudnn
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib

        # PyTorch also needs to know where your local "lib/libcuda.so" lives.
        # If you're not on NixOS, you should provide the right path (likely
        # another one).
        "/run/opengl-driver"
      ];
    in {
      default = pkgs.mkShell {
        packages = [
          pkgs.python312
          pkgs.python312Packages.venvShellHook
        ];

        env = {
          CC = "${pkgs.gcc}/bin/gcc"; # For `torch.compile`.
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;
        };

        venvDir = ".venv";
        postVenvCreation = ''
          # This is run only when creating the virtual environment.
          pip install torch==2.5.1 numpy==2.2.2
        '';
        postShellHook = ''
          # This is run every time you enter the devShell.
          python3 -c "import torch; print('CUDA available' if torch.cuda.is_available() else 'CPU only')"
        '';
      };
    });
  };
}
