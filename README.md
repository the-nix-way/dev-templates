# Nix flake templates for easy dev environments

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

To initialize (where `${ENV}` is listed in the table below):

```shell
nix flake init --template github:the-nix-way/dev-templates#${ENV}
```

Here's an example (for the [`rust`](./rust) template):

```shell
# Initialize in the current project
nix flake init --template github:the-nix-way/dev-templates#rust

# Create a new project
nix flake new --template github:the-nix-way/dev-templates#rust ${NEW_PROJECT_DIRECTORY}
```

## How to use the templates

Once your preferred template has been initialized, you can use the provided shell in two ways:

1. If you have [`nix-direnv`][nix-direnv] installed, you can initialize the environment by running `direnv allow`.
2. If you don't have `nix-direnv` installed, you can run `nix develop` to open up the Nix-defined shell.

## Available templates

| Language/framework/tool  | Template                  |
| :----------------------- | :------------------------ |
| [Clojure]                | [`clojure`](./clojure/)   |
| [Cue]                    | [`cue`](./cue/)           |
| [Dhall]                  | [`dhall`](./dhall/)       |
| [Elixir]                 | [`elixir`](./elixir/)     |
| [Elm]                    | [`elm`](./elm/)           |
| [Gleam]                  | [`gleam`](./gleam/)       |
| [Go] 1.17                | [`go1_17`](./go1.17/)     |
| [Go] 1.18                | [`go1_18`](./go1.18/)     |
| [Hashicorp] tools        | [`hashi`](./hashi/)       |
| [Java]                   | [`java`](./java/)         |
| [Kotlin]                 | [`kotlin`](./kotlin/)     |
| [Nickel]                 | [`nickel`](./nickel/)     |
| [Nim]                    | [`nim`](./nim/)           |
| [Nix]                    | [`nix`](./nix/)           |
| [Node.js][node]          | [`node`](./node/)         |
| [OCaml]                  | [`ocaml`](./ocaml/)       |
| [Open Policy Agent][opa] | [`opa`](./opa)            |
| [Protobuf]               | [`protobuf`](./protobuf/) |
| [Ruby]                   | [`ruby`](./ruby/)         |
| [Rust]                   | [`rust`](./rust/)         |
| [Scala]                  | [`scala`](./scala/)       |
| [Zig]                    | [`zig`](./zig/)           |

## Template contents

The sections below list what each template includes. In all cases, you're free to add and remove packages as you see fit; the templates are just boilerplate.

### [`clojure`](./clojure/)

- [Clojure] 1.11.1.1149
- [Boot] 2.8.3
- [Leiningen] 2.9.8

### [`cue`](./cue/)

- [Cue] 0.4.3
- [nix-cue]

### [`dhall`](./dhall)

- [Dhall] 1.40.2
- [dhall-bash]
- [dhall-csv] (Linux only)
- [dhall-docs]
- [dhall-json]
- [dhall-lsp-server]
- [dhall-nix]
- [dhall-nixpkgs]
- [dhall-openapi]
- [dhall-text] (Linux only)
- [dhall-toml]
- [dhall-yaml]

### [`elixir`](./elixir/)

- [Elixir] 1.13.4, including [mix] and [IEx]
- [gigalixir] (Linux only)

### [`elm`](./elm/)

- [Elm] 0.19.1
- [elm2nix] 0.2.1

### [`gleam`](./gleam/)

- [Gleam] 0.22.1

### [`go1.17`](./go1.17/)

- [Go] 1.17
- Standard Go tools ([goimports], [godoc], and others)
- [golangci-lint]

### [`go1.18`](./go1.18/)

- [Go] 1.18
- Standard Go tools ([goimports], [godoc], and others)
- [golangci-lint]

### [`hashi`](./hashi/)

- [Packer] 1.8.2
- [Terraform] 1.2.7
- [Nomad] 1.2.9
- [Vault] 1.11.2
- [nomad-autoscaler] 0.3.6-dev
- [nomad-pack] 0.0.1-techpreview.3
- [levant] 0.3.1-dev
- [damon]
- [Terragrunt] 0.37.0

### [`haskell`](./haskell/)

- [GHC][haskell] 9.0.2
- [cabal] 3.6.2.0

### [`java`](./java)

- [Java] 17.0.3
- [Maven] 3.8.5
- [Gradle] 7.5
- [Ant] 1.10.11

### [`kotlin`](./kotlin/)

- [Kotlin] 1.7.10-release-333
- [Gradle] 7.5

### [`nickel`](./nickel/)

- [Nickel] 0.2.0

### [`nim`](./nim)

- [Nim] 1.6.6
- [nimble] 0.13.1

### [`nix`](./nix/)

- [Cachix] 0.8.1
- [dhall-to-nix] 1.1.23
- [lorri]
- [niv]
- [nixfmt]
- [statix]
- [vulnix]

### [`node`](./node/)

- [Node.js][node] 18.7.0
- [npm] 8.15.0
- [pnpm] 7.9.1
- [Yarn] 1.22.19
- [node2nix] 1.11.1

### [`ocaml`](./ocaml/)

- [OCaml] 4.13.1
- [Dune] 3.4.1
- [odoc] 2.1.1
- [ocamlformat] 0.24.0

### [`opa`](./opa/)

- [Open Policy Agent][opa] 0.43.0
- [Conftest] 0.34.0

### [`protobuf`](./protobuf/)

- The [Buf CLI][buf] 1.7.0
- [protoc][protobuf] 3.19.4

### [`python`](./python/)

- [Python] 3.11.0rc1
- [pip] 22.1.2
- [Virtualenv] 20.15.1
- [mach-nix]

### [`ruby`](./ruby/)

- [Ruby] 3.1.2p20, plus the standard Ruby tools (`bundle`, `gem`, etc.)

### [`rust`](./rust/)

- [Rust], including [cargo], [Clippy], and the other standard tools. The Rust version is determined as follows, in order:

  - From the `rust-toolchain.toml` file if present
  - From the `rust-toolchain` file if present
  - Version 1.63.0 if neither is present

- [rust-analyzer] 2022-08-01
- [cargo-audit] 0.17.0
- [cargo-deny] 0.12.1
- [cross] 0.2.4

### [`scala`](./scala/)

- [Scala] 3.1.0 ([Java] 17.0.3)
- [sbt] 1.7.1

### [`zig`](./zig/)

- [Zig] 0.9.1

## Code organization

All of the templates have only the root [flake](./flake.nix) as a flake input. That root flake provides a common revision of [Nixpkgs] and [`flake-utils`][flake-utils] to all the templates.

[ant]: https://ant.apache.org
[boot]: https://www.boot-clj.com
[buf]: https://github.com/bufbuild/buf
[cabal]: https://www.haskell.org/cabal
[cachix]: https://www.cachix.org
[cargo]: https://doc.rust-lang.org/cargo
[cargo-audit]: https://crates.io/crates/cargo-audit
[cargo-deny]: https://crates.io/crates/cargo-deny
[clippy]: https://github.com/rust-lang/rust-clippy
[clojure]: https://clojure.org
[conftest]: https://www.conftest.dev
[cross]: https://github.com/cross-rs/cross
[cue]: https://cuelang.org
[damon]: https://github.com/hashicorp/damon
[dhall]: https://dhall-lang.org
[dhall-bash]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-bash
[dhall-csv]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-csv
[dhall-docs]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-docs
[dhall-json]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-json
[dhall-lsp-server]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-lsp-server
[dhall-nix]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nix
[dhall-nixpkgs]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nixpkgs
[dhall-openapi]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-openapi
[dhall-text]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-text
[dhall-to-nix]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nix
[dhall-toml]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-toml
[dhall-yaml]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-yaml
[dune]: https://dune.build
[elixir]: https://elixir-lang.org
[elm]: https://elm-lang.org
[elm2nix]: https://github.com/cachix/elm2nix
[flake-utils]: https://github.com/numtide/flake-utils
[gigalixir]: https://www.gigalixir.com
[gleam]: https://gleam.run
[go]: https://go.dev
[godoc]: https://pkg.go.dev/golang.org/x/tools/cmd/godoc
[goimports]: https://pkg.go.dev/golang.org/x/tools/cmd/goimports
[golangci-lint]: https://github.com/golangci/golangci-lint
[gradle]: https://gradle.org
[hashicorp]: https://hashicorp.com
[haskell]: https://haskell.org
[iex]: https://hexdocs.pm/iex/IEx.html
[java]: https://java.com
[kotlin]: https://kotlinlang.org
[leiningen]: https://leiningen.org
[levant]: https://github.com/hashicorp/levant
[lorri]: https://github.com/target/lorri
[mach-nix]: https://github.com/DavHau/mach-nix
[maven]: https://maven.apache.org
[mix]: https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
[nickel]: https://nickel-lang.org
[nim]: https://nim-lang.org
[nimble]: https://github.com/nim-lang/nimble
[niv]: https://github.com/nmattia/niv
[nix]: https://nixos.org
[nix-cue]: https://github.com/jmgilman/nix-cue
[nixfmt]: https://github.com/serokell/nixfmt
[nixpkgs]: https://github.com/NixOS/nixpkgs
[nix-direnv]: https://github.com/nix-community/nix-direnv
[node]: https://nodejs.org
[node2nix]: https://github.com/svanderburg/node2nix
[nomad]: https://nomadproject.io
[nomad-autoscaler]: TOhttps://github.com/hashicorp/nomad-autoscaler
[nomad-pack]: https://github.com/hashicorp/nomad-pack
[npm]: https://npmjs.org
[ocaml]: https://ocaml.org
[ocamlformat]: https://github.com/ocaml-ppx/ocamlformat
[odoc]: https://github.com/ocaml/odoc
[opa]: https://openpolicyagent.org
[packer]: https://packer.io
[pip]: https://pypi.org/project/pip
[phoenix]: https://phoenixframework.org
[pnpm]: https://pnpm.io
[protobuf]: https://developers.google.com/protocol-buffers
[python]: https://python.org
[ruby]: https://ruby-lang.org
[rust]: https://rust-lang.org
[rust-analyzer]: https://rust-analyzer.github.io
[scala]: https://scala-lang.org
[statix]: https://github.com/nerdypepper/statix
[sbt]: https://www.scala-sbt.org
[terraform]: https://terraform.io
[terragrunt]: https://terragrunt.gruntwork.io
[vault]: https://www.vaultproject.io
[virtualenv]: https://pypi.org/project/virtualenv
[vulnix]: https://github.com/flyingcircusio/vulnix
[yarn]: https://yarnpkg.com
[zig]: https://ziglang.org
