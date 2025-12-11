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
        "update.mode" = "none"; #fixing when tries to update and fails. annoying popup everytime
        # "remote.SSH.syncConfiguration" = false;
        # "remote.downloadExtensionsLocally" = true;
        "workbench.colorTheme" = "One Dark Pro";
        "remote.autoForwardPortsSource"= "hybrid"; #a bit shady, no?
      };
      keybindings = [
        {
          key = "ctrlCmd";
          command = "editor.multiCursorModifier";
        }
      ];
      # no idea why, but capital letters here break the confing...
      extensions = with pkgs.vscode-extensions; [
        # https://github.com/nix-community/vscode-nix-ide - check additional configurations for nix-ide
        # ghcopilot seems to be needing alot of manual setup due to ms restrictions
        # github.copilot
        # github.copilot-chat
        jnoortheen.nix-ide
        mechatroner.rainbow-csv
        zhuangtongfa.material-theme

        # Open-VSX extension needs to be downloaded manually. Check if this persists after hms 
        # open_remote_openvsx

        # nextflow.nextflow
        # snakemake.snakemake-lang
        # yukina.yukinord
        # asvetliakov.vscode-neovim
      ];
    };

    

  };

}
