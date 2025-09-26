{ pkgs, ... }:

{
  # move to separate file?
  home.packages = [ 
    pkgs.nil
    pkgs.vscodium
     ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      userSettings = {
        "nix.enableLanguageServer" = true;
        "editor.fontFamily" = " 'JetBrains Mono' ";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        "terminal.integrated.fontFamily" = "'JetBrains Mono'";
        "terminal.integrated.fontSize" = 14;
      };
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
        # nextflow.nextflow
        # snakemake.snakemake-lang
        # yukina.yukinord
        # asvetliakov.vscode-neovim

      ];
    };

  };

}
