{ pkgs ? import <nixpkgs> {} }:
let
  sources = import ./sources.nix;
  nix-pre-commit-hooks = import sources."pre-commit-hooks.nix";
  gitignore = ./gitignore.nix { inherit (pkgs) lib; };
in
nix-pre-commit-hooks.run {
  src = gitignore.gitignoreSource ./.;
  excludes = [ "^nix/sources\.nix$" ];
  hooks = {
    nixpkgs-fmt.enable = true;
    nix-linter.enable = true;
  };
}
