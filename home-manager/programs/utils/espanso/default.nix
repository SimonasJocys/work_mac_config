{ pkgs, ... }:

{
  home.packages = [ pkgs.espanso ];
  # something is wrong with file backups/collisions
  services.espanso.enable = true;

# opens search window 
# move this to separate .yml file
  services.espanso.configs = {
    default = {
      search_shortcut = "META+SHIFT+SPACE"; #alt is option on macos, meta is command
      disable_x11_fast_inject =  true; #fixing kitty problem as per https://github.com/espanso/espanso/issues/281
    };
  };

# copies all matches
home.file.".config/espanso/match/expand.yml".source = ./expand.yml;

}

