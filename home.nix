{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.


  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.

  home = {
    username = "poustouflan";
    homeDirectory = "/home/poustouflan";
    packages = with pkgs; [
      flameshot
    ];
  };

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;

    git = {
      enable = true;
      userName = "Quentin Rataud";
      userEmail = "quentin.rataud" + "@" + "epita.fr";
      aliases = {
        lg = "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      ignores = [ "*~" "*.swp" ".o" ".d" "format_marker"];
    };
  };


  home.stateVersion = "21.05";
}
