{
  description = "A Nix-flake-based Python development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });

      /*
       * Change this value ({major}{min}) to
       * update the Python virtual-environment
       * version. When you do this, make sure
       * to delete the `.venv` directory to
       * have the hook rebuild it for the new
       * version, since it won't overwrite an
       * existing one. After this, reload the
       * development shell to rebuild it.
       * You'll see a warning asking you to
       * do this when version mismatches are
       * present. For safety, removal should
       * be a manual step, even if trivial.
       */
      version = 313;
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }:
        let python = pkgs."python${toString version}";
        in
        {
          default = pkgs.mkShellNoCC {
            venvDir = ".venv";

            postShellHook = ''
              venvVersionWarn() {
              	local majorMinor
              	majorMinor="$("$venvDir/bin/python" -c 'import platform; print("".join(platform.python_version_tuple()[0:2]))')"

              	[[ "$majorMinor" == "${toString version}" ]] && return

              	cat <<EOF
              Warning: Python version mismatch: (.venv) $majorMinor != ${toString version}
                       Delete '$venvDir' and reload to rebuild for version ${toString version}
              EOF
              }

              venvVersionWarn
            '';

            packages = [
              python.pkgs.venvShellHook
              python.pkgs.pip

              /* Add whatever else you'd like here. */
              # pkgs.basedpyright
              # pkgs.black
              # pkgs.ruff
            ];
          };
        });
    };
}
