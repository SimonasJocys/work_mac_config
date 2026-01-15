{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initExtra = ''
      cd() {
        builtin cd "$@" && ls
      }
    '';
  };

  programs.zsh.oh-my-zsh.enable = true;
}
