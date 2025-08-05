{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hello
  ];
  home = {
    username = "simon";
    homeDirectory = "/Users/simon";
  };

  home.stateVersion = "25.11"; # Set this to the version you're starting with
}
