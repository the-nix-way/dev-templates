{
  description = "A Nix-flake-based Elixir development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        inherit (pkgs)
          darwin gigalixir inotify-tools libnotify mkShell terminal-notifier;
        inherit (pkgs.beam.packages.erlangR25) elixir elixir_ls;
        inherit (pkgs.darwin.apple_sdk.frameworks) CoreFoundation CoreServices;
        inherit (pkgs.lib) optionals;
        inherit (pkgs.stdenv) isDarwin isLinux;

        linuxDeps = optionals isLinux [ gigalixir inotify-tools libnotify ];
        darwinDeps = optionals isDarwin [ terminal-notifier ]
          ++ [ CoreFoundation CoreServices ];
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ elixir elixir_ls ] ++ linuxDeps ++ darwinDeps;

            shellHook = ''
              ${elixir}/bin/mix --version
              ${elixir}/bin/iex --version
            '';
          };
        };
      });
}
