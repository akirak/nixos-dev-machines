{ lib }:
let
  sources = import ./sources.nix;
in
import sources."gitignore.nix" {
  inherit lib
    }
