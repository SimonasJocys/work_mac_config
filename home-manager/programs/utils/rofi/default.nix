{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-calc rofi-emoji ];
    # terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rafi;
  };
}