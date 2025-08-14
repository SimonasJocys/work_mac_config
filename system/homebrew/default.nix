{ ... }: 

#for now homebrew needs to be installed manually:
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# it also needs to be manually sourced/added to zsh - TODO: move this to nix config



{
homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    # taps = ["albertlauncher/albert"]; # repos/complex addons 
    brews = [ ]; # aka Formulas? packages #does this delete packages through nix?
    # casks = [ "albert" ]; # GUI or large binaries 
};
}