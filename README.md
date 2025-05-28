# Nix flake templates for easy dev environments

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

---

## NOTICE for recent changes

Several language toolchains were removed due to low popularity.

Some other toolchains are migrating to better implementation from other projects.

Sorry for any inconvenience :(

---

To initialize (where `${ENV}` is listed in the table below):

```shell
nix flake init --template github:definfo/dev-templates#${ENV}
```

## How to use the templates

Once your preferred template has been initialized, you can use the provided shell in two ways:

1. If you have [`nix-direnv`][nix-direnv] installed, you can initialize the environment by running `direnv allow`.
2. If you don't have `nix-direnv` installed, you can run `nix develop` to open up the Nix-defined shell.

## Available templates/projects

| Language/framework/tool | Template/Project                                                  |
| :---------------------- | :---------------------------------------------------------------- |
| C/C++                   | [`c-cpp`](./c-cpp/) Also refer to (https://wiki.nixos.org/wiki/C) |
| Coq                     | [`coq`](./coq/)                                                   |
| Go                      | [`gomod2nix`](https://github.com/nix-community/gomod2nix)         |
| Haskell                 | [`haskell-flake`](https://github.com/srid/haskell-flake)          |
| Haskell                 | [`cabal2nix`](https://github.com/NixOS/cabal2nix)                 |
| Java                    | [`java`](./java/)                                                 |
| Jupyter                 | [`uv2nix TODO`](https://pyproject-nix.github.io/uv2nix/)          |
| Kotlin                  | [`kotlin`](./kotlin/)                                             |
| LaTeX                   | [`latex`](./latex/)                                               |
| Nix                     | [`nix`](./nix/)                                                   |
| Node.js                 | [`node`](./node/)                                                 |
| Node.js                 | [`node2nix`](https://github.com/svanderburg/node2nix)             |
| OCaml                   | [`ocaml`](./ocaml/)                                               |
| OCaml                   | [`opam-nix`](https://github.com/tweag/opam-nix)                   |
| Python                  | [`uv2nix`](https://pyproject-nix.github.io/uv2nix/)               |
| Rust                    | [`rust`](./rust/)                                                 |
| Rust                    | [`naersk`](https://github.com/nix-community/naersk)               |
| Rust                    | [`crate2nix`](https://nix-community.github.io/crate2nix/)         |
| Rust toolchains         | [`fenix`](https://github.com/nix-community/fenix)                 |
| Scala                   | [`scala-seed`](https://github.com/DevInsideYou/scala-seed)        |
| Scala                   | [`scala`](./scala/)                                               |
| Shell                   | [`shell`](./shell/)                                               |
| Tauri                   | [`tauri`](./tauri)                                                |
| Typst                   | [`typst`](./typst)                                                |
| Typst                   | [`press`](https://github.com/RossSmyth/press)                     |
| Typst                   | [`typix`](https://github.com/loqusion/typix)                      |
| Zig                     | [`zig2nix`](https://github.com/Cloudef/zig2nix)                   |
| Zig                     | [`zon2nix`](https://github.com/nix-community/zon2nix)             |

## Template contents

The sections below list what each template includes. In all cases, you're free to add and remove packages as you see fit; the templates are just boilerplate.

### [`c-cpp`](./c-cpp/)

- clang-tools
- cmake
- codespell
- conan
- cppcheck
- doxygen
- gdb / lldb
- gtest
- lcov
- ninja
- vcpkg
- vcpkg-tool

### [`coq`](./coq/)

- Coq

### [`java`](./java/)

- Java
- Maven
- Gradle
- jdtls

### [`kotlin`](./kotlin/)

- Kotlin
- Gradle

### [`latex`](./latex/)

- texlive
- tectonic
- texlab

### [`nix`](./nix/)

- cachix
- dhall-to-nix
- lorri
- niv
- nixfmt
- statix
- vulnix

### [`node`](./node/)

- Node.js
- npm
- pnpm
- Yarn
- node2nix

### [`ocaml`](./ocaml/)

- OCaml
- Dune
- odoc
- ocamlformat

### [`rust`](./rust/)

- Rust toolchain (`rust-overlay`)
- just
- cargo-audit
- cargo-bloat
- cargo-license
- cargo-llvm-cov
- cargo-nextest
- cargo-outdated
- cargo-show-asm
- samply
- valgrind
- watchexec
- bacon

### [`scala`](./scala/)

- Scala (Java)
- sbt
- coursier

### [`shell`](./shell/)

- shellcheck
- shfmt
- just

### [`typst`](./typst)

- typst
- tinymist

### [`tauri`](./tauri)

- Include `rust` and `node` dependencies.
- gtk3
- libsoup
- webkitgtk
- cairo

## Code organization

All of the templates have only the root [flake](./flake.nix) as a flake input. That root flake provides a common revision of [Nixpkgs] and [`flake-parts`][flake-parts] to all the templates.
