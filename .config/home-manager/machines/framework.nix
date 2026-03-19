{ config, pkgs, ... }:

{
  imports = [
    ../groups/base.nix
    ../groups/development.nix
    ../groups/graphical.nix
    ../groups/graphical-linux.nix
  ];

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };
}
