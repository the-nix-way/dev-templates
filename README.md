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
| [C]/[C++]               | [`c-cpp`](./c-cpp/) Also refer to (https://wiki.nixos.org/wiki/C) |
| [Coq]                   | [`coq`](./coq/)                                                   |
| [Go]                    | [`gomod2nix`](https://github.com/nix-community/gomod2nix)         |
| [Haskell]               | [`haskell-flake`](https://github.com/srid/haskell-flake)          |
| [Haskell]               | [`cabal2nix`](https://github.com/NixOS/cabal2nix)                 |
| [Java]                  | [`java`](./java/)                                                 |
| [Jupyter]               | [`uv2nix TODO`](https://pyproject-nix.github.io/uv2nix/)          |
| [Kotlin]                | [`kotlin`](./kotlin/)                                             |
| [LaTeX]                 | [`latex`](./latex/)                                               |
| [Nix]                   | [`nix`](./nix/)                                                   |
| [Node.js][node]         | [`node`](./node/)                                                 |
| [Node.js][node]         | [`node2nix`](https://github.com/svanderburg/node2nix)             |
| [OCaml]                 | [`ocaml`](./ocaml/)                                               |
| [OCaml]                 | [`opam-nix`](https://github.com/tweag/opam-nix)                   |
| [Python]                | [`uv2nix`](https://pyproject-nix.github.io/uv2nix/)               |
| [Rust]                  | [`naersk`](https://github.com/nix-community/naersk)               |
| [Rust]                  | [`crate2nix`](https://nix-community.github.io/crate2nix/)         |
| [Rust toolchains][rust] | [`fenix`](https://github.com/nix-community/fenix)                 |
| [Scala]                 | [`scala-seed`](https://github.com/DevInsideYou/scala-seed)        |
| [Scala]                 | [`scala`](./scala/)                                               |
| [Shell]                 | [`shell`](./shell/)                                               |
| [Tauri]                 | [`tauri`](./tauri)                                                |
| [Typst]                 | [`typst`](./typst)                                                |
| [Typst]                 | [`press`](https://github.com/RossSmyth/press)                     |
| [Typst]                 | [`typix`](https://github.com/loqusion/typix)                      |
| [Zig]                   | [`zig2nix`](https://github.com/Cloudef/zig2nix)                   |
| [Zig]                   | [`zon2nix`](https://github.com/nix-community/zon2nix)             |

## Template contents

The sections below list what each template includes. In all cases, you're free to add and remove packages as you see fit; the templates are just boilerplate.

### [`c-cpp`](./c-cpp/)

- [clang-tools] 17.0.6
- [cmake] 3.28.3
- [codespell] 2.2.6
- [conan] 2.0.17
- [cppcheck] 2.13.4
- [doxygen] 1.10.0
- [gdb] 14.1
- [gtest] 1.12.1
- [lcov] 1.0
- [vcpkg]
- [vcpkg-tool]

### [`coq`](./cue/)

- [Coq] 8.15.2

### [`java`](./java/)

- [Java] 20.0.1+9
- [Maven] 3.9.2
- [Gradle] 9.0.1
- [jdtls] 1.31.0

### [`kotlin`](./kotlin/)

- [Kotlin] 1.9.0
- [Gradle] 8.0.1

### [`latex`](./latex/)

- [texlive]
- [tectonic]
- [texlab]

### [`nix`](./nix/)

- [Cachix] 1.6
- [dhall-to-nix] 1.1.25
- [lorri] 1.6.0
- [niv] 0.2.22
- [nixfmt] 0.5.0
- [statix] 0.5.6
- [vulnix]

### [`node`](./node/)

- [Node.js][node] 18.16.1
- [npm] 9.5.1
- [pnpm] 8.6.6
- [Yarn] 1.22.19
- [node2nix] 1.11.1

### [`ocaml`](./ocaml/)

- [OCaml] 4.14.1
- [Dune] 3.9.1
- [odoc] 2.2.0
- [ocamlformat] 0.25.1

### [`scala`](./scala/)

- [Scala] 2.13.11 ([Java] 19.0.1)
- [sbt] 1.9.2

### [`shell`](./shell/)

- [shellcheck] 0.9.0

### [`typst`](./typst)

- [typst] 0.12.0
- [tinymist] 0.12.12

### [`tauri`](./tauri)

- Include [`rust`] and [`node`] dependencies.
- [gtk3]
- [libsoup]
- [webkitgtk]
- [cairo]

## Code organization

All of the templates have only the root [flake](./flake.nix) as a flake input. That root flake provides a common revision of [Nixpkgs] and [`flake-utils`][flake-utils] to all the templates.

[boot]: https://boot-clj.com
[buf]: https://github.com/bufbuild/buf
[bun]: https://bun.sh
[C]: https://open-std.org/jtc1/sc22/wg14
[C++]: https://isocpp.org
[cabal]: https://haskell.org/cabal
[cachix]: https://cachix.org
[cargo]: https://doc.rust-lang.org/cargo
[cargo-audit]: https://crates.io/crates/cargo-audit
[cargo-deny]: https://crates.io/crates/cargo-deny
[cargo-edit]: https://crates.io/crates/cargo-edit
[clang-tools]: https://clang.llvm.org
[clippy]: https://github.com/rust-lang/rust-clippy
[clojure]: https://clojure.org
[cmake]: https://cmake.org
[codespell]: https://github.com/codespell-project/codespell
[composer]: https://getcomposer.org
[conan]: https://conan.io
[conftest]: https://conftest.dev
[Coq]: https://coq.inria.fr
[cppcheck]: http://cppcheck.sourceforge.net
[csharp]: https://dotnet.microsoft.com/en-us/languages/csharp
[cue]: https://cuelang.org
[damon]: https://github.com/hashicorp/damon
[dhall]: https://dhall-lang.org
[dhall-bash]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-bash
[dhall-docs]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-docs
[dhall-json]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-json
[dhall-lsp-server]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-lsp-server
[dhall-nix]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nix
[dhall-nixpkgs]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nixpkgs
[dhall-openapi]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-openapi
[dhall-to-nix]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nix
[dhall-toml]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-toml
[dhall-yaml]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-yaml
[dotnet]: https://dotnet.microsoft.com/en-us
[doxygen]: https://doxygen.nl
[dune]: https://dune.build
[elixir]: https://elixir-lang.org
[elm]: https://elm-lang.org
[elm2nix]: https://github.com/cachix/elm2nix
[flake-utils]: https://github.com/numtide/flake-utils
[gdb]: https://gnu.org/software/gdb
[gigalixir]: https://gigalixir.com
[gleam]: https://gleam.run
[go]: https://go.dev
[godoc]: https://pkg.go.dev/golang.org/x/tools/cmd/godoc
[goimports]: https://pkg.go.dev/golang.org/x/tools/cmd/goimports
[golangci-lint]: https://github.com/golangci/golangci-lint
[gradle]: https://gradle.org
[gtest]: https://github.com/google/googletest
[hashicorp]: https://hashicorp.com
[haskell]: https://haskell.org
[haxe]: https://haxe.org
[iex]: https://hexdocs.pm/iex/IEx.html
[java]: https://java.com
[jdtls]: https://projects.eclipse.org/projects/eclipse.jdt.ls
[jq]: https://jqlang.github.io/jq
[jupyter]: https://jupyter.org
[knitr]: https://yihui.org/knitr
[kotlin]: https://kotlinlang.org
[latex]: https://latex-project.org
[lean]: https://lean-lang.org
[lcov]: https://ltp.sourceforge.net/coverage/lcov.php
[leiningen]: https://leiningen.org
[levant]: https://github.com/hashicorp/levant
[lldb]: https://lldb.llvm.org
[lorri]: https://github.com/target/lorri
[maven]: https://maven.apache.org
[mix]: https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
[mono]: https://mono-project.com
[msbuild]: https://github.com/dotnet/msbuild
[nickel]: https://nickel-lang.org
[nim]: https://nim-lang.org
[nimble]: https://github.com/nim-lang/nimble
[niv]: https://github.com/nmattia/niv
[nix]: https://nixos.org
[nixfmt]: https://github.com/serokell/nixfmt
[nixpkgs]: https://github.com/NixOS/nixpkgs
[nix-direnv]: https://github.com/nix-community/nix-direnv
[node]: https://nodejs.org
[node2nix]: https://github.com/svanderburg/node2nix
[nomad]: https://nomadproject.io
[nomad-autoscaler]: https://github.com/hashicorp/nomad-autoscaler
[nomad-pack]: https://github.com/hashicorp/nomad-pack
[npm]: https://npmjs.org
[ocaml]: https://ocaml.org
[ocamlformat]: https://github.com/ocaml-ppx/ocamlformat
[odoc]: https://github.com/ocaml/odoc
[omnisharp-roslyn]: https://github.com/OmniSharp/omnisharp-roslyn
[opa]: https://openpolicyagent.org
[pandoc]: https://pandoc.org
[packer]: https://packer.io
[pip]: https://pypi.org/project/pip
[phoenix]: https://phoenixframework.org
[php]: https://php.net
[platformio]: https://platformio.org
[python]: https://python.org
[pnpm]: https://pnpm.io
[protobuf]: https://developers.google.com/protocol-buffers
[pulumi]: https://pulumi.com
[purescript]: https://github.com/purescript/purescript
[purescript-language-server]: https://github.com/nwolverson/purescript-language-server
[purs-tidy]: https://github.com/natefaubion/purescript-tidy
[python]: https://python.org
[r]: https://r-project.org
[release]: https://github.com/NixOS/nixpkgs/releases/tag/22.11
[rmarkdown]: https://rmarkdown.rstudio.com
[ruby]: https://ruby-lang.org
[rust]: https://rust-lang.org
[rust-analyzer]: https://rust-analyzer.github.io
[scala]: https://scala-lang.org
[shellcheck]: https://shellcheck.net
[statix]: https://github.com/nerdypepper/statix
[sbt]: https://scala-sbt.org
[sourcekit-lsp]: https://github.com/swiftlang/sourcekit-lsp
[spago]: https://github.com/purescript/spago
[swi-prolog]: https://www.swi-prolog.org
[swift]: https://swift.org
[tauri]: https://v1.tauri.app
[tectonic]: https://tectonic-typesetting.github.io
[terraform]: https://terraform.io
[terragrunt]: https://terragrunt.gruntwork.io
[texlab]: https://github.com/latex-lsp/texlab
[texlive]: https://tug.org/texlive
[tflint]: https://github.com/terraform-linters/tflint
[tinymist]: https://github.com/Myriad-Dreamin/tinymist
[typst]: https://typst.app
[vault]: https://vaultproject.io
[vcpkg]: https://vcpkg.io
[vcpkg-tool]: https://github.com/microsoft/vcpkg-tool
[vulnix]: https://github.com/flyingcircusio/vulnix
[yarn]: https://yarnpkg.com
[vlang]: https://vlang.io
[zig]: https://ziglang.org
[zls]: https://github.com/zigtools/zls
