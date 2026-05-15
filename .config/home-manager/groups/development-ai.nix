{ pkgs, ... }:
{
  home.packages = [
	pkgs.pi-coding-agent
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  services.ollama = {
    enable = true;
  };
}
