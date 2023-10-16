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

| Language/framework/tool  | Template                      |
| :----------------------- | :---------------------------- |
| [Clojure]                | [`clojure`](./clojure/)       |
| [C#][csharp]             | [`csharp`](./csharp/)         |
| [Cue]                    | [`cue`](./cue/)               |
| [Dhall]                  | [`dhall`](./dhall/)           |
| [Elixir]                 | [`elixir`](./elixir/)         |
| [Elm]                    | [`elm`](./elm/)               |
| [Gleam]                  | [`gleam`](./gleam/)           |
| [Go]                     | [`go`](./go/)                 |
| [Hashicorp] tools        | [`hashi`](./hashi/)           |
| [Haxe]                   | [`haxe`](./haxe/)             |
| [Java]                   | [`java`](./java/)             |
| [Kotlin]                 | [`kotlin`](./kotlin/)         |
| [LaTeX]                  | [`latex`](./latex/)           |
| [Nickel]                 | [`nickel`](./nickel/)         |
| [Nim]                    | [`nim`](./nim/)               |
| [Nix]                    | [`nix`](./nix/)               |
| [Node.js][node]          | [`node`](./node/)             |
| [OCaml]                  | [`ocaml`](./ocaml/)           |
| [Open Policy Agent][opa] | [`opa`](./opa)                |
| [PHP]                    | [`php`](./php/)               |
| [Protobuf]               | [`protobuf`](./protobuf/)     |
| [Pulumi]                 | [`pulumi`](./pulumi/)         |
| [Purescript]             | [`purescript`](./purescript/) |
| [Ruby]                   | [`ruby`](./ruby/)             |
| [Rust]                   | [`rust`](./rust/)             |
| [Scala]                  | [`scala`](./scala/)           |
| [Shell]                  | [`shell`](./shell/)           |
| [Zig]                    | [`zig`](./zig/)               |

## Template contents

The sections below list what each template includes. In all cases, you're free to add and remove packages as you see fit; the templates are just boilerplate.

### [`clojure`](./clojure/)

- [Clojure] 1.11.1.1347
- [Boot] 2.8.3
- [Leiningen] 2.10.0

### [`csharp`](./csharp/)

- [dotnet] sdk 7 (7.0.305)
- [omnisharp-roslyn]
- [Mono] 6.12.0.182
- [msbuild] 16.10.1

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

### [`java`](./java)

- [Java] 20.0.1+9
- [Maven] 3.9.2
- [Gradle] 9.0.1

### [`kotlin`](./kotlin/)

- [Kotlin] 1.9.0
- [Gradle] 8.0.1

### [`latex`](./latex/)

- [texlive]
- [tectonic]
- [texlab]

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

### [`opa`](./opa/)

- [Open Policy Agent][opa] 0.54.0
- [Conftest] 0.44.0

### [`php`](./php/)

- [PHP] 8.2.8
- [Composer] 2.5.8

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
- [Virtualenv] 20.19.0

### [`ruby`](./ruby/)

- [Ruby] 3.2.2, plus the standard Ruby tools (`bundle`, `gem`, etc.)

### [`rust`](./rust/)

- [Rust], including [cargo], [Clippy], and the other standard tools. The Rust version is determined as follows, in order:

  - From the `rust-toolchain.toml` file if present
  - From the `rust-toolchain` file if present
  - Version 1.70.0 if neither is present

- [rust-analyzer] 2023-07-10
- [cargo-audit] 0.17.0
- [cargo-deny] 0.12.1

### [`scala`](./scala/)

- [Scala] 2.13.11 ([Java] 19.0.1)
- [sbt] 1.9.2

### [`shell`](./shell/)

- [shellcheck] 0.9.0

### [`zig`](./zig/)

- [Zig] 0.10.1

## Code organization

All of the templates have only the root [flake](./flake.nix) as a flake input. That root flake provides a common revision of [Nixpkgs] and [`flake-utils`][flake-utils] to all the templates.

[boot]: https://www.boot-clj.com
[buf]: https://github.com/bufbuild/buf
[cabal]: https://www.haskell.org/cabal
[cachix]: https://www.cachix.org
[cargo]: https://doc.rust-lang.org/cargo
[cargo-audit]: https://crates.io/crates/cargo-audit
[cargo-deny]: https://crates.io/crates/cargo-deny
[clippy]: https://github.com/rust-lang/rust-clippy
[clojure]: https://clojure.org
[composer]: https://getcomposer.org/
[conftest]: https://www.conftest.dev
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
[dotnet]: https://dotnet.microsoft.com/en-us/
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
[haxe]: https://haxe.org/
[iex]: https://hexdocs.pm/iex/IEx.html
[java]: https://java.com
[jq]: https://jqlang.github.io/jq
[kotlin]: https://kotlinlang.org
[latex]: https://www.latex-project.org/
[leiningen]: https://leiningen.org
[levant]: https://github.com/hashicorp/levant
[lorri]: https://github.com/target/lorri
[maven]: https://maven.apache.org
[mix]: https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
[mono]: https://www.mono-project.com/
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
[packer]: https://packer.io
[pip]: https://pypi.org/project/pip
[phoenix]: https://phoenixframework.org
[php]: https://php.net/
[pnpm]: https://pnpm.io
[protobuf]: https://developers.google.com/protocol-buffers
[pulumi]: https://pulumi.com/
[purescript]: https://github.com/purescript/purescript
[purescript-language-server]: https://github.com/nwolverson/purescript-language-server
[purs-tidy]: https://github.com/natefaubion/purescript-tidy
[python]: https://python.org
[release]: https://github.com/NixOS/nixpkgs/releases/tag/22.11
[ruby]: https://ruby-lang.org
[rust]: https://rust-lang.org
[rust-analyzer]: https://rust-analyzer.github.io
[scala]: https://scala-lang.org
[shellcheck]: https://www.shellcheck.net/
[statix]: https://github.com/nerdypepper/statix
[sbt]: https://www.scala-sbt.org
[spago]: https://github.com/purescript/spago
[tectonic]: https://tectonic-typesetting.github.io/
[terraform]: https://terraform.io
[terragrunt]: https://terragrunt.gruntwork.io
[texlab]: https://github.com/latex-lsp/texlab
[texlive]: https://www.tug.org/texlive/
[tflint]: https://github.com/terraform-linters/tflint
[vault]: https://www.vaultproject.io
[virtualenv]: https://pypi.org/project/virtualenv
[vulnix]: https://github.com/flyingcircusio/vulnix
[yarn]: https://yarnpkg.com
[zig]: https://ziglang.org
