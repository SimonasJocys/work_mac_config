{ pkgs, ... }:

{
  programs.defaults = {
    NSGlobalDomain = {
      "NSUserKeyEquivalents" = {
        "Cut" = "^X";
        "Save" = "^S";
      };
    };
  };
}