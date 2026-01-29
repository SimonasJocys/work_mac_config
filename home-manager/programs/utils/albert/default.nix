{ pkgs, lib, config,  ... }:

{
  imports = [
    ./albert_espanso.nix
    ./albert_shortcuts.nix
    ./albert_oryx.nix
  ];
}
