{ pkgs, ... }:

{
  home.packages = [
    pkgs.swayidle
    pkgs.firefoxpwa
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  # Desktop
  programs.sway = {
    enable = true;
    package = pkgs.sway;
    wrapperFeatures.gtk = true;
  };
  programs.swaylock = {
    enable = true;
    package = pkgs.sway;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };
  services.mako.enable = true;
  services.blueman-applet.enable = true;
  services.lxqt-policykit-agent.enable = true;

  # Browser
  services.gnome.gnome-browser-connector.enable = true;
  programs.firefox = {
    package = pkgs.firefox-bin.override {
      nativeMessagingHosts = [
        pkgs.gnome-browser-connector
        pkgs.firefoxpwa
      ];
    };
  };
}
