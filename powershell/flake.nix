{
  description = "A Nix-flake-based PowerShell development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";

  outputs =
    { self, ... }@inputs:

    let
      inherit (inputs.nixpkgs) lib;

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forEachSupportedSystem =
        f:
        lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              powershell

              # For using this with NeoVim on linux, set the lspconfig cmd for powershell_es as below (or, at a minimum, you need the -Stdio flag):
              # cmd = function(dispatchers)
              #     local temp_path = vim.fn.stdpath('cache')
              #     local command =
              #       [["powershell-editor-services -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es.session.json' -HostName nvim -Stdio -LogLevel Information"]]:format(temp_path, temp_path)
              #     return vim.lsp.rpc.start(vim.split(command, " "), dispatchers)
              # end
              powershell-editor-services
            ];
          };
        }
      );
    };
}
