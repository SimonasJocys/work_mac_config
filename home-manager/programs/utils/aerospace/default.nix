{
  lib,
  pkgs,
  ...
}: {
    # Installed with brew, this for some reason stopped working 
    # home.packages = with pkgs; [
    #   aerospace
    # ];

    # Source aerospace config from the home-manager store
    home.file.".aerospace.toml".text = ''
        start-at-login = true
    '';
}
