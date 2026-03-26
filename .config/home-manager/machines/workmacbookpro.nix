{ pkgs, ... }:

{
  imports = [
    ../groups/base.nix
    ../groups/development.nix
    ../groups/graphical.nix
    ../groups/graphical-darwin.nix
  ];

  home.packages = [
    pkgs._1password-cli
    pkgs._1password-gui
    # pkgs.cloudflare-warp
    # (pkgs.callPackage ../pkgs/tunnelblick.nix { })
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  nixpkgs.config.allowUnfreePackages = [
    "1password"
    "1password-cli"
    "cloudflare-warp"
  ];
}
