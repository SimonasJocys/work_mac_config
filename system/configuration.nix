{
  pkgs,
  outputs,
  ...
}: {

networking.hostName = "simons-MacBook-Air";

# from https://github.com/AlexNabokikh/nix-config/blob/master/modules/darwin/common/default.nix
  # Nixpkgs configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  system.stateVersion = 6;

  imports = [
    ./homebrew
    ];

  # Nix settings
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = true;
    package = pkgs.nix;
  };

  # User configuration
  users.users.simon = {
    name = "simon";
    home = "/Users/simon";
  };

  environment.systemPackages = [
     pkgs.vim
     ];

  # Add ability to use TouchID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Passwordless sudo
  # security.sudo.extraConfig = "${userConfig.name}    ALL = (ALL) NOPASSWD: ALL";

#   system.activationScripts.appShortcuts.text = ''

#   # Get the console user's UID
#   uid=$(id -u $(stat -f %Su /dev/console))

#   # Run defaults as the logged-in user
#   defaults write -g NSUserKeyEquivalents -dict-add "Minimize" "@~m"
#   launchctl asuser "$uid" defaults write -g NSUserKeyEquivalents -dict-add "Save" "^S"
#   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
# '';

  # System settings
  system = {
    defaults = {
      controlcenter = {
        BatteryShowPercentage = true;
        NowPlaying = false;
      };
      CustomUserPreferences = {
        NSUserKeyEquivalents = {
          "Lock Screen" = "@^l";
          # "Paste and Match Style" = "^$v";
          "Paste and Match Style" = "^v";
          "Save" = "^S";
        };
        # "com.apple.symbolichotkeys" = {
        #   AppleSymbolicHotKeys = {
        #     "163" = {
        #       # Set 'Option + N' for Show Notification Center
        #       enabled = true;
        #       value = {
        #         parameters = [
        #           110
        #           45
        #           524288
        #         ];
        #         type = "standard";
        #       };
        #     };
        #     "184" = {
        #       # Set 'Option + Shift + R' for Screenshot and recording options
        #       enabled = true;
        #       value = {
        #         parameters = [
        #           114
        #           15
        #           655360
        #         ];
        #         type = "standard";
        #       };
        #     };
        #     "60" = {
        #       # Disable '^ + Space' for selecting the previous input source
        #       enabled = false;
        #     };
        #     "61" = {
        #       # Set 'Option + Space' for selecting the next input source
        #       enabled = 1;
        #       value = {
        #         parameters = [
        #           32
        #           49
        #           524288
        #         ];
        #         type = "standard";
        #       };
        #     };
        #     "64" = {
        #       # Disable 'Cmd + Space' for Spotlight Search
        #       enabled = false;
        #     };
        #     "65" = {
        #       # Disable 'Cmd + Alt + Space' for Finder search window
        #       enabled = false;
        #     };
        #     "238" = {
        #       # Set 'Control + Command + C' to center focused window
        #       enabled = true;
        #       value = {
        #         parameters = [
        #           99
        #           8
        #           1310720
        #         ];
        #         type = "standard";
        #       };
        #     };
        #   };
        # };
        NSGlobalDomain."com.apple.mouse.linear" = true;

      };
      NSGlobalDomain = {
 
        "com.apple.sound.beep.volume" = 0.000;
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        PMPrintingExpandedStateForPrint = true;
      };
      LaunchServices = {
        LSQuarantine = false;
      };
      trackpad = {
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        Clicking = true;
      };
      finder = {
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
      dock = {
        autohide = false;
        expose-animation-duration = 0.01;
        show-recents = false;
        showhidden = true;
        persistent-apps = [ 
          "/System/Applications/System Settings.app"
          "/System/Applications/Launchpad.app"
          "/Users/simon/Applications/Home Manager Apps/Obsidian.app"
          "/Users/simon/Applications/Home Manager Apps/Brave Browser.app"
          "/Users/simon/Applications/Home Manager Apps/Firefox.app"
          "/Users/simon/Applications/Home Manager Apps/VSCodium.app"
          "/Users/simon/Applications/Home Manager Apps/KeePassXC.app"
          "/Applications/Microsoft Outlook.app"
          "/Applications/Microsoft Teams.app"
          "/Users/simon/Applications/Home Manager Apps/Alacritty.app"
           ];
        tilesize = 40;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        mru-spaces = false;
      };
      screencapture = {
        location = "/Users/simon/Downloads/temp";
        type = "png";
        disable-shadow = true;
      };
    };
    # keyboard = {
    #   enableKeyMapping = true;
    #   # Remap §± to ~
    #   userKeyMapping = [
    #     {#not working yet :(
    #       HIDKeyboardModifierMappingDst = 30064771125;
    #       HIDKeyboardModifierMappingSrc = 30064771172;
    #     }
    #   ];
    # };
    primaryUser = "simon";
  };

  # Zsh configuration - seems needed even if there is one on hm
  programs.zsh.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    # nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono

  ];
}