{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/ambrose";

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.aerospace.enable = true;

  services.colima.profiles.default.settings.vmType = "vz";
  services.colima.profiles.default.settings.rosetta = true;
  services.colima.profiles.default.settings.mountType = "virtiofs";
}
