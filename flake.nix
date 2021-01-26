{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.pebble = {
    url = "github:Sorixelle/pebble.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.rust-overlay = {
    url = "github:oxalica/rust-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, pebble, flake-utils, rust-overlay, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlay ];
        };
        rust = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain;
      in {
        devShell = pebble.pebbleEnv.${system} {
          nativeBuildInputs = [ rust ];
        };
      });
}
