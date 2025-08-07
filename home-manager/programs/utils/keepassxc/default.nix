{ pkgs, ... }:

{
  home.packages = [ 
    pkgs.keepassxc
     ];

# manually add //(.*)// as per https://keepassxc.org/docs/KeePassXC_UserGuide#_auto_type
  home.file.".config/keepassxc/keepassxc.ini".source = ./keepassxc.ini;


# TODO: add option for autostart - right now it is added manually
}