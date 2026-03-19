{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/ambrose";

  home.packages = [
    pkgs.swayidle
    pkgs.firefoxpwa
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.swaylock.enable = true;
  programs.waybar.enable = true;
  services.mako.enable = true;
  services.blueman-applet.enable = true;
  services.lxqt-policykit-agent.enable = true;

  services.gnome.gnome-browser-connector.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      nativeMessagingHosts = [
        pkgs.gnome-browser-connector
        pkgs.firefoxpwa
      ];
    };
  };
}
