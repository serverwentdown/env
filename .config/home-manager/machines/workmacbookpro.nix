{ pkgs, ... }:

{
  imports = [
    ../groups/base.nix
    ../groups/development.nix
    ../groups/development-ai.nix
    ../groups/graphical.nix
    ../groups/graphical-darwin.nix
  ];

  home.packages = [
    # Password management

    pkgs._1password-cli
    pkgs._1password-gui

	# Connectivity
    # pkgs.cloudflare-warp
    (pkgs.callPackage ../pkgs/installer-tunnelblick.nix { })

	# Developer tools
	pkgs.claude-code
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  nixpkgs.config.allowUnfreePackages = [
    "1password"
    "1password-cli"
    "cloudflare-warp"
	"claude-code"
  ];
}
