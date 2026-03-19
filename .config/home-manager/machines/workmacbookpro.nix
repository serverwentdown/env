{ config, pkgs, ... }:

{
  imports = [
    ../groups/base.nix
    ../groups/development.nix
    ../groups/graphical.nix
    ../groups/graphical-darwin.nix
  ];

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  services.colima.enable = true;
}
