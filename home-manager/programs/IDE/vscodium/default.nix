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
        "update.mode" = "none"; # fixing when tries to update and fails. annoying popup everytime
        
        "remote.SSH.syncConfiguration" = false; # was commented before
        "remote.downloadExtensionsLocally" = true; # was commented before

        "workbench.colorTheme" = "One Dark Pro";
        "remote.autoForwardPortsSource" = "hybrid"; # a bit shady, no?
      };
      keybindings = [
        {
          key = "ctrlCmd";
          command = "editor.multiCursorModifier";
        }
      ];

      extensions =
        with pkgs.vscode-extensions;
        [
  # https://github.com/nix-community/vscode-nix-ide - check additional configurations for nix-ide
  # ghcopilot seems to be needing alot of manual setup due to ms restrictions
  # no idea why, but capital letters here break the confing...
  # github.copilot
  # github.copilot-chat


  # also: snakemake and github extentions seems to be "breaking everyting related to extentions, that sometimes they are the only ones installed"          jnoortheen.nix-ide
          mechatroner.rainbow-csv
          zhuangtongfa.material-theme
          ms-python.python
          ms-toolsai.jupyter
          ms-python.black-formatter
          jnoortheen.nix-ide

        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
# this seems to be the way to install open-vsx.org extentions

          {
            name = "nextflow";
            publisher = "nextflow";
            version = "1.5.2";
            sha256 = "VxpxBmZ7y0cEX4YOWvXXf3l2se0LThYysEH1yplB67I=";
          }
          {
            name = "snakemake-lang";
            publisher = "snakemake";
            version = "0.7.0";
            sha256 = "KKUYoEyYEsXNkRpqsCQOM/1pirO2DT6wTwkGsFbFxJ0=";
          }
          # does not seem to work. Need manual install. Maybe add as separate install with let statement?
          # {
          #   name = "open-remote-ssh";
          #   publisher = "jeanp413";
          #   version = "0.0.48";
          #   sha256 = "QfJnAAx+kO2iJ1EzWoO5HLogJKg3RiC3hg1/u2Jm6t4="; # use nix-prefetch or leave placeholder
          # }
        ];

    };

  };

}
