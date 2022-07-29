# Nix flake templates for easy dev environments

To initialize (where `${ENV}` is listed in the table below):

```shell
nix flake init --template github:the-nix-way/dev-templates#${ENV}
```

Here's an example (for the [`rust`](./rust) template):

```shell
nix flake init --template github:the-nix-way/dev-templates#rust
```

Available templates:

| Language/framework/tool | Template              |
| :---------------------- | :-------------------- |
| [Dhall]                 | [`dhall`](./dhall/)   |
| [Elixir]                | [`elixir`](./elixir/) |
| [Gleam]                 | [`gleam`](./gleam/)   |
| [Go] 1.17               | [`go1_17`](./go1.17/) |
| [Go] 1.18               | [`go1_18`](./go1.18/) |
| [Java]                  | [`java`](./java/)     |
| [Kotlin]                | [`kotlin`](./kotlin/) |
| [Nix]                   | [`nix`](./nix/)       |
| [Node.js][node]         | [`node`](./node/)     |
| [Rust]                  | [`rust`](./rust/)     |
| [Scala]                 | [`scala`](./scala/)   |
| [Zig]                   | [`zig`](./zig/)       |

[dhall]: https://dhall-lang.org
[elixir]: https://elixir-lang.org
[gleam]: https://gleam.run
[go]: https://go.dev
[java]: https://java.com
[kotlin]: https://kotlinlang.org
[nix]: https://nixos.org
[node]: https://nodejs.org
[rust]: https://rust-lang.org
[scala]: https://scala-lang.org
[zig]: https://ziglang.org
