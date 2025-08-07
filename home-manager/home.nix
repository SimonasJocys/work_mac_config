{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    hello
  ];
  home = {
    username = "simon";
    homeDirectory = "/Users/simon";
  };

  imports = [
    ./programs/IDE/vscodium
    ./programs/IDE/nixvim
    ./programs/shell/zsh
    ./programs/shell/alacrity
    ./programs/shell/starship
    ./programs/utils/alfred
    ./programs/utils/obsidian
    ./programs/utils/git
    ./programs/utils/fzf
    ./programs/utils/espanso
    ./programs/utils/keepass
    ./programs/browsers/brave
    ./programs/browsers/firefox
    ./programs/browsers/chromium
  ];

  home.stateVersion = "25.11"; # Set this to the version you're starting with
}
