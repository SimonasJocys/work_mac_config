{ config, pkgs, catppuccin, ... }:

{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # hello
  ];
  home = {
    username = "simon";
    homeDirectory = "/Users/simon";
  };

  imports = [
    ./programs/IDE/vscodium
    ./programs/IDE/nixvim
    # ./programs/shell/zsh
    ./programs/shell/ttyper
    ./programs/shell/alacrity
    # ./programs/shell/starship
    ./programs/utils/raycast
    ./programs/utils/obsidian

    ./programs/utils/git
    ./programs/utils/aerospace

    # ./programs/utils/fzf
    ./programs/utils/espanso
    ./programs/utils/keepassxc
    ./programs/browsers/brave
    ./programs/browsers/firefox
    # ./programs/browsers/chromium #not working on macos
  ];

    nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
    };
  };


  catppuccin = {
    flavor = "macchiato";
    accent = "lavender";
  };

  home.stateVersion = "25.05"; # Set this to the version you're starting with
}
