{ pkgs, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "~/Desktop/repos/work_mac_config"; # sets NH_OS_FLAKE variable for you. Somehow not working? Setting manually in espanso

    # maybe try this from nh output:
              #     [env: NH_OS_FLAKE=]
              # [env: NH_HOME_FLAKE=]
              # [env: NH_DARWIN_FLAKE=]
  };
}