{ pkgs, ... }:
let
  yamlFormat = pkgs.formats.yaml { };
  mkColimaConfiguration = import ../configurations/colima.nix;
in
{
  home.packages = [
    # Networking
    pkgs.nmap
    pkgs.ipcalc
    pkgs.oha

    # Source control
    pkgs.gh
    pkgs.git
    pkgs.git-lfs

    # Package managers
    pkgs.pnpm
    pkgs.uv

    # Bootstrap toolchains
    pkgs.go
    pkgs.rustup

    # Language servers
    pkgs.yaml-language-server
    pkgs.vscode-json-languageserver
    pkgs.jq-lsp
    pkgs.nixd
    pkgs.nixfmt
    pkgs.lua-language-server
    pkgs.bash-language-server
    pkgs.docker-language-server
	pkgs.hadolint
    pkgs.terraform-ls
    pkgs.tflint
    pkgs.gopls
    pkgs.golangci-lint
    pkgs.golangci-lint-langserver
    pkgs.basedpyright
    pkgs.vue-language-server
    pkgs.vtsls
    pkgs.openscad-lsp
	pkgs.nginx-language-server

    # Formatters
    pkgs.shfmt

    # Emulation
    (pkgs.qemu.override { toolsOnly = true; })

    # Containers
    pkgs.docker-client
    pkgs.docker-credential-helpers
    pkgs.kubectl
    pkgs.kubectl-cnpg
    pkgs.kubectl-df-pv
    pkgs.kubectl-graph
    pkgs.kubectl-ktop
    pkgs.kubectl-tree
    pkgs.kubernetes-helm
	pkgs.dive

    # Infrastructure
    pkgs.google-cloud-sdk
    pkgs.ssm-session-manager-plugin
    pkgs.terraform
  ];

  home.file = {
    ".colima/_templates/default.yaml".source =
      yamlFormat.generate "default.yaml"
        (mkColimaConfiguration {
          vmType = if pkgs.stdenv.isDarwin then "vz" else "qemu";
        });
  };

  home.sessionVariables = {
    COLIMA_SAVE_CONFIG = "false";
  };

  # Utilities
  programs.difftastic.enable = true;

  # Networking
  programs.aria2.enable = true;

  # Source control
  # programs.gh.enable = true;
  # programs.git = {
  #   enable = true;
  #   lfs.enable = true;
  # };

  # Package managers
  # programs.uv.enable = true;

  # Containers
  programs.k9s.enable = true;
  services.colima = {
    enable = true;
    dockerPackage = pkgs.docker-client;
    profiles.default = {
      isActive = true;
      isService = false;
      setDockerHost = true;
      settings = mkColimaConfiguration {
        vmType = if pkgs.stdenv.isDarwin then "vz" else "qemu";
      };
    };
  };

  # Infrastructure
  programs.awscli.enable = true;

  nixpkgs.config.allowUnfreePackages = [ "terraform" ];
}
