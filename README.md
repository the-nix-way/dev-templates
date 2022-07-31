# Nix flake templates for easy dev environments

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

| Language/framework/tool | Template                  |
| :---------------------- | :------------------------ |
| [Dhall]                 | [`dhall`](./dhall/)       |
| [Elixir]                | [`elixir`](./elixir/)     |
| [Gleam]                 | [`gleam`](./gleam/)       |
| [Go] 1.17               | [`go1_17`](./go1.17/)     |
| [Go] 1.18               | [`go1_18`](./go1.18/)     |
| [Java]                  | [`java`](./java/)         |
| [Kotlin]                | [`kotlin`](./kotlin/)     |
| [Nix]                   | [`nix`](./nix/)           |
| [Node.js][node]         | [`node`](./node/)         |
| [Protobuf]              | [`protobuf`](./protobuf/) |
| [Rust]                  | [`rust`](./rust/)         |
| [Scala]                 | [`scala`](./scala/)       |
| [Zig]                   | [`zig`](./zig/)           |

## Template contents

The sections below list what each template includes. In all cases, you're free to add and remove packages as you see fit; the templates are just boilerplate.

### [`dhall`](./dhall)

- [Dhall] 1.40.2
- [`dhall-bash`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-bash)
- [`dhall-csv`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-csv) (Linux only)
- [`dhall-docs`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-docs)
- [`dhall-json`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-json)
- [`dhall-lsp-server`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-lsp-server)
- [`dhall-nix`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nix)
- [`dhall-nixpkgs`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nixpkgs)
- [`dhall-openapi`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-openapi)
- [`dhall-text`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-text) (Linux only)
- [`dhall-toml`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-toml)
- [`dhall-yaml`](https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-yaml)

### [`elixir`](./elixir/)

- [Elixir] 1.13.4, including [mix] and [IEx]
- [Node.js][node] 18.7.0 (largely for [Phoenix] projects)

### [`gleam`](./gleam/)

- [Gleam] 0.22.1

## Code organization

All of the templates have only the root [flake](./flake.nix) as a flake input. That root flake provides a common revision of [Nixpkgs] and [`flake-utils`][flake-utils] to all the templates.

[dhall]: https://dhall-lang.org
[elixir]: https://elixir-lang.org
[flake-utils]: https://github.com/numtide/flake-utils
[gleam]: https://gleam.run
[go]: https://go.dev
[iex]: https://hexdocs.pm/iex/IEx.html
[java]: https://java.com
[kotlin]: https://kotlinlang.org
[mix]: https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
[nix]: https://nixos.org
[nixpkgs]: https://github.com/NixOS/nixpkgs
[nix-direnv]: https://github.com/nix-community/nix-direnv
[node]: https://nodejs.org
[phoenix]: https://phoenixframework.org
[protobuf]: https://developers.google.com/protocol-buffers
[rust]: https://rust-lang.org
[scala]: https://scala-lang.org
[zig]: https://ziglang.org
