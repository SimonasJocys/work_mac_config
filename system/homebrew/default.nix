{ ... }: 

#for now homebrew needs to be installed manually: - or install nix-homwbrew:https://www.youtube.com/watch?v=Z8BL8mdzWHI&t=282s
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# it also needs to be manually sourced/added to zsh - TODO: move this to nix config

# it seems macos correctly indexes homebrew apps 

{
homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall"; #or zap|uninstall

    taps = ["albertlauncher/albert" "nikitabobko/aerospace"]; # repos/complex addons 
    brews = [ # aka Formulas? packages #does this delete packages through nix?
         "python"
          ]; #installed for albert plugins to work
    casks = [ # GUI or large binaries
        "albert"
         "amethyst" 
         "redquits" 
         "aerospace"
         ];  
};
}