{ pkgs, lib, ... }:

{
  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  # Desktop
  programs.rio.enable = true;

  # Editor
  programs.zed-editor.enable = true;

  # Browser
  programs.firefox = {
    enable = true;
    package = lib.mkDefault pkgs.firefox-bin;
    policies = {
      ExtensionSettings =
        let
          moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        in
        {
          "uBlock0@raymondhill.net" = {
            install_url = moz "ublock-origin";
            installation_mode = "force_installed";
          };
          "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = {
            install_url = moz "auto-tab-discard";
            installation_mode = "force_installed";
          };
          "{442789cf-4ff6-4a85-bf5b-53aa3282f1a2}" = {
            install_url = moz "auto-tab-groups";
            installation_mode = "force_installed";
          };
          "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
            install_url = moz "styl-us";
            installation_mode = "force_installed";
          };
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            install_url = moz "vimium-ff";
            installation_mode = "force_installed";
          };
          "{488d9d28-b604-46b9-a8de-5615261ed347}" = {
            install_url = moz "github-live-prs";
            installation_mode = "force_installed";
          };
        };
    };
    profiles.default = {
      isDefault = true;
      settings = {
        "browser.ai.control.sidebarChatbot" = "blocked";
        "extensions.autoDisableScopes" = 0;
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "hide-sidebar";
      };
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          auto-tab-discard
          # auto-tab-groups
          stylus
          vimium
          # github-live-prs
        ];
      };
    };
  };

  nixpkgs.config.allowUnfreePackages = [
    "firefox-bin"
    "firefox-bin-unwrapped"
  ];
}
