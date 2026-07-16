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
    pkgs.corepack
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
	pkgs.nixfmt-tree
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
  programs.difftastic = {
    enable = true;
    package = pkgs.difftastic;
  };

  # Networking
  programs.aria2 = {
    enable = true;
    package = pkgs.aria2;
  };

  # Containers
  programs.k9s = {
    enable = true;
    package = pkgs.k9s;
  };
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
  programs.awscli = {
    enable = true;
    package = pkgs.awscli2;
  };

  nixpkgs.config.allowUnfreePackages = [ "terraform" ];
}
