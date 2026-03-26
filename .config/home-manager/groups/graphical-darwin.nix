{ pkgs, ... }:

{
  home.homeDirectory = "/Users/ambrose";

  home.packages = [
    pkgs.firefox-bin-unwrapped
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  # Desktop
  programs.aerospace.enable = true;

  # Browser
  programs.firefox.package = null;
}
