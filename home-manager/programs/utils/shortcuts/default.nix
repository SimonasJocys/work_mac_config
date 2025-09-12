{ pkgs, lib, ... }:

{
  # defaults need to have a full path (e.g. just defaults works in terminal, but not hm)
  # /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u settings for instant reload?
  # using settings -> keyboard -> app shortcuts seems to override - use cautiosly
  # actual names of the functions can be find in app windows - e.g. vscodium -> File -> see shortcuts/names
  # it seems that original commands are still working, see if there is way to remove those
  # "^$\\U2192" ---> ctrl + shift + left
  # command to check defaults - defaults read -g NSUserKeyEquivalents
  # todo - check what is alt key equivalent - command or option
  # maybe move app specific commands to app specific options, not defaults?
  # double defined commands (same shortcut) seems to be not working at all
  # maybe find a way to delete all the shortcuts beforehand?
  # shortcuts are added and preserved if not deleted - nuke on each iteration?
  # some global seem not to work on non registered apps - ones installed through home manager? 
    # seems to be problem only with firefox for now
  # add that activation/linking script
  home.activation.myPostActivation =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''

      echo ">>> Nuking all general shortcuts"
      if /usr/bin/defaults read -g NSUserKeyEquivalents &>/dev/null; then
        /usr/bin/defaults delete -g NSUserKeyEquivalents
          fi

      echo ">>> Setting general shortcuts"
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Save" "^s"
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Cut" "^x"
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Copy" "^c"
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Paste" "^v"
      
      
      
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Undo" "^z"
      
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Select All" "^a"
      
      echo ">>> Setting VSCode shortcuts"
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "New Text File" "^n"
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Toggle Line Comment" "^/"
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Command Palette" "^p"
      /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Open..." "^o"


      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
}

# /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Find" "^f"
# /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Redo" "^y"

# /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Expand Selection" "^$\\U2190" 
# /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "Shrinc Selection" "^$\\U2192"
# /usr/bin/defaults write -g NSUserKeyEquivalents -dict-add "New Window" "^n"
      # echo ">>> Nuking all general shortcuts"
      # /usr/bin/defaults delete -g NSUserKeyEquivalents