# Nix flake templates for easy dev environments

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

To initialize (where `${ENV}` is listed in the table below):

```shell
nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#${ENV}"
```

Here's an example (for the [`rust`](./rust) template):

```shell
# Initialize in the current project
nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#rust"

# Create a new project
nix flake new --template "https://flakehub.com/f/the-nix-way/dev-templates/*#rust" ${NEW_PROJECT_DIRECTORY}
```

## How to use the templates

Once your preferred template has been initialized, you can use the provided shell in two ways:

1. If you have [`nix-direnv`][nix-direnv] installed, you can initialize the environment by running `direnv allow`.
2. If you don't have `nix-direnv` installed, you can run `nix develop` to open up the Nix-defined shell.

## Available templates

| Language/framework/tool          | Template                              |
| :------------------------------- | :------------------------------------ |
| [Bun]                            | [`bun`](./bun/)                       |
| [C]/[C++]                        | [`c-cpp`](./c-cpp/)                   |
| [Clojure]                        | [`clojure`](./clojure/)               |
| [Cue]                            | [`cue`](./cue/)                       |
| [Dhall]                          | [`dhall`](./dhall/)                   |
| [Elixir]                         | [`elixir`](./elixir/)                 |
| [Elm]                            | [`elm`](./elm/)                       |
| Empty (change at will)           | [`empty`](./empty)                    |
| [Gleam]                          | [`gleam`](./gleam/)                   |
| [Go]                             | [`go`](./go/)                         |
| [Hashicorp] tools                | [`hashi`](./hashi/)                   |
| [Haskell]                        | [`haskell`](./haskell/)               |
| [Haxe]                           | [`haxe`](./haxe/)                     |
| [Java]                           | [`java`](./java/)                     |
| [Jupyter]                        | [`jupyter`](./jupyter/)               |
| [Kotlin]                         | [`kotlin`](./kotlin/)                 |
| [LaTeX]                          | [`latex`](./latex/)                   |
| [Nickel]                         | [`nickel`](./nickel/)                 |
| [Nim]                            | [`nim`](./nim/)                       |
| [Nix]                            | [`nix`](./nix/)                       |
| [Node.js][node]                  | [`node`](./node/)                     |
| [OCaml]                          | [`ocaml`](./ocaml/)                   |
| [Odin]                           | [`odin`](./odin/)                     |
| [Open Policy Agent][opa]         | [`opa`](./opa)                        |
| [PHP]                            | [`php`](./php/)                       |
| [PlatformIO]                     | [`platformio`](./platformio/)         |
| [Protobuf]                       | [`protobuf`](./protobuf/)             |
| [Pulumi]                         | [`pulumi`](./pulumi/)                 |
| [Purescript]                     | [`purescript`](./purescript/)         |
| [Python]                         | [`python`](./python/)                 |
| [R]                              | [`r`](./r/)                           |
| [Ruby]                           | [`ruby`](./ruby/)                     |
| [Rust]                           | [`rust`](./rust/)                     |
| [Rust from toolchain file][rust] | [`rust-toolchain`](./rust-toolchain/) |
| [Scala]                          | [`scala`](./scala/)                   |
| [Shell]                          | [`shell`](./shell/)                   |
| [SWI-prolog]                     | [`swi-prolog`](./swi-prolog/)         |
| [Swift]                          | [`swift`](./swift)                    |
| [Vlang]                          | [`vlang`](./vlang/)                   |
| [Zig]                            | [`zig`](./zig/)                       |

## Template contents

The sections below list what each template includes. In all cases, you're free to add and remove packages as you see fit; the templates are just boilerplate.

### [`bun`](./bun/)

- [bun] 1.1.29

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

### [`clojure`](./clojure/)

- [Clojure] 1.11.1.1347
- [Boot] 2.8.3
- [Leiningen] 2.10.0

### [`cue`](./cue/)

- [Cue] 0.5.0

### [`dhall`](./dhall)

- [Dhall] 1.41.2
- [dhall-bash]
- [dhall-docs]
- [dhall-json]
- [dhall-lsp-server]
- [dhall-nix]
- [dhall-nixpkgs]
- [dhall-openapi]
- [dhall-toml]
- [dhall-yaml]

### [`elixir`](./elixir/)

- [Elixir] 1.14.5, including [mix] and [IEx]
- [gigalixir] (Linux only)

### [`elm`](./elm/)

- [Elm] 0.19.1
- [elm2nix]

### [Empty](./empty/)

A dev template that's fully customizable.

### [`gleam`](./gleam/)

- [Gleam] 0.30.0

### [`go`](./go/)

- [Go] 1.20.5
- Standard Go tools ([goimports], [godoc], and others)
- [golangci-lint]

### [`hashi`](./hashi/)

- [Packer] 1.8.6
- [Terraform] 1.5.2
- [Nomad] 1.4.6
- [Vault] 1.13.3
- [nomad-autoscaler] 0.3.6-dev
- [nomad-pack] 0.0.1-techpreview.3
- [levant] 0.3.2-dev
- [damon]
- [Terragrunt] 0.45.13
- [tflint] 0.46.1

### [`haskell`](./haskell/)

- [GHC][haskell] 9.2.8
- [cabal] 3.10.1.0

### [`haxe`](./haxe/)

- [Haxe] 4.2.5

### [`java`](./java/)

- [Java] 20.0.1+9
- [Maven] 3.9.2
- [Gradle] 9.0.1
- [jdtls] 1.31.0

### [`jupyter`](./jupyter/)

- [Jupyter core][jupyter] 5.7.2

### [`kotlin`](./kotlin/)

- [Kotlin] 1.9.0
- [Gradle] 8.0.1

### [`latex`](./latex/)

- [texlive]
- [tectonic]
- [texlab]

### [`lean4`](./lean4/)

- [Lean] 4.9.0

### [`nickel`](./nickel/)

- [Nickel] 0.2.0

### [`nim`](./nim)

- [Nim] 1.6.14
- [nimble] 0.14.2

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

### [`odin`](./odin/)

- [Odin] 4.14.1

### [`opa`](./opa/)

- [Open Policy Agent][opa] 0.54.0
- [Conftest] 0.44.0

### [`php`](./php/)

- [PHP] 8.2.8
- [Composer] 2.5.8

### [`platformio`](./platformio/)

- [PlatformIO] 6.1.11

### [`protobuf`](./protobuf/)

- The [Buf CLI][buf] 1.23.1
- [protoc][protobuf] 3.21.12

### [`pulumi`](./pulumi/)

- [Pulumi] 3.72.1
- [Python] 3.11.4
- [Go] 1.20.5
- [Node.js][node] 18.16.1
- [dotnet] sdk 6
- [Java] 19.0.1 and [Maven] 3.9.2
- [jq] 1.6

### [`purescript`](./purescript/)

- [Purescript] (purs) 0.15.9
- [Spago] 0.21.0
- [purescript-language-server] 0.17.1
- [purs-tidy] 0.10.0

### [`python`](./python/)

- [Python] 3.11.4
- [pip] 23.0.1

### [`r`](./r/)

- [R] 4.3.1
- [rmarkdown] 2.22
- [knitr] 1.43 ([pandoc] and [texlive])

### [`ruby`](./ruby/)

- [Ruby] 3.2.2, plus the standard Ruby tools (`bundle`, `gem`, etc.)

### [`rust`](./rust/)

- [Rust], including [cargo], [Clippy], and the other standard tools. The Rust version is determined as follows, in order:

  - From the `rust-toolchain.toml` file if present
  - From the `rust-toolchain` file if present
  - Version 1.78.0 if neither is present

- [rust-analyzer] 2024-04-29
- [cargo-edit] 0.12.2
- [cargo-deny] 0.14.23

### [`scala`](./scala/)

- [Scala] 2.13.11 ([Java] 19.0.1)
- [sbt] 1.9.2

### [`shell`](./shell/)

- [shellcheck] 0.9.0

### [`swi-prolog`](./swi-prolog/)

- [swipl][swi-prolog] 9.2.7

### [`swift`](./swift/)

- [Swift] 5.8
- [sourcekit-lsp]

### [`vlang`](./vlang/)

- [Vlang] 0.4.4

### [`zig`](./zig/)

- [Zig] 0.10.1
- [LLDB] 16.0.6
- [ZLS] 0.13.0

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
[cppcheck]: http://cppcheck.sourceforge.net
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
[odin]: https://github.com/odin-lang/Odin
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
[tectonic]: https://tectonic-typesetting.github.io
[terraform]: https://terraform.io
[terragrunt]: https://terragrunt.gruntwork.io
[texlab]: https://github.com/latex-lsp/texlab
[texlive]: https://tug.org/texlive
[tflint]: https://github.com/terraform-linters/tflint
[vault]: https://vaultproject.io
[vcpkg]: https://vcpkg.io
[vcpkg-tool]: https://github.com/microsoft/vcpkg-tool
[vulnix]: https://github.com/flyingcircusio/vulnix
[yarn]: https://yarnpkg.com
[vlang]: https://vlang.io
[zig]: https://ziglang.org
[zls]: https://github.com/zigtools/zls
