{ pkgs, ... }:

{
  # move to separate file?
  home.packages = [ pkgs.nil ];


programs.vscode = {
  enable = true;
  package = pkgs.vscodium;
  keybindings = [
    {
    key = "ctrlCmd";
    command = "editor.multiCursorModifier";
    }
    ];
  extensions = with pkgs.vscode-extensions; [
    # https://github.com/nix-community/vscode-nix-ide - check additional configurations for nix-ide
    jnoortheen.nix-ide
    mechatroner.rainbow-csv
    # asvetliakov.vscode-neovim
  ];
  
  userSettings = {
            "nix.enableLanguageServer" = true;
        };
};



}