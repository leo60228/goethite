{
  inputs.pebble.url = "github:Sorixelle/pebble.nix";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, pebble, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell = pebble.pebbleEnv.${system} {};
    });
}
