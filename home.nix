{ config, pkgs, lib, ... }:
let
discordUpdated = pkgs.discord.override rec {
    version = "0.0.16";
    src = builtins.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "1s9qym58cjm8m8kg3zywvwai2i3adiq6sdayygk2zv72ry74ldai";
    };
  };
in
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

  xsession.windowManager.i3 = import ./i3.nix { inherit pkgs lib; };

  home = {
    username = "poustouflan";
    homeDirectory = "/home/poustouflan";
    packages = with pkgs; [
      flameshot
      discordUpdated
      thefuck oh-my-zsh zsh-powerlevel10k
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
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "robbyrussell";
      };
      # zplug = {
      #   enable = true;
      #   plugins = [
      #     { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      #     { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } 
      #   ];
      # };
    };
  };


  home.stateVersion = "21.05";
}
