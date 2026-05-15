{ pkgs, ... }:

{
  imports = [
    ../groups/base.nix
    ../groups/development.nix
    ../groups/development-ai.nix
  ];

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };
}
