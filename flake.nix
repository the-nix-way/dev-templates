{
  description = "Ready-made templates for easily creating flake-driven environments";

  outputs = { self }: {
    templates = {
      gleam = {
        path = ./gleam;
        description = "Gleam development environment";
      };

      go_1_17 = {
        path = ./go1.17;
        description = "Go 1.17 development environment";
      };

      go_1_18 = {
        path = ./go1.18;
        description = "Go 1.18 development environment";
      };

      rust = {
        path = ./rust;
        description = "Rust development environment";
      };

      zip = {
        path = ./zig;
        description = "Zig development environment";
      };
    };
  };
}
