{
  description = "Tauri development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:fractal-tess/nix-systems";
  };

  outputs =
    { nixpkgs, systems, ... }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      packages =
        pkgs: with pkgs; [
          pkg-config
          gobject-introspection
          gtk3
          pango
          cairo
          gdk-pixbuf
          glib
          libsoup_3
          webkitgtk_4_1
          atkmm
          mold

          cargo
          rustc
          rustfmt

          mold
          clang

          nodejs_22
          pnpm
          nodePackages."npm-check-updates"
          npkill
        ];
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = packages pkgs;
        };
      });
    };
}
