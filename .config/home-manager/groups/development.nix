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

    # Language servers
    pkgs.nixd
    pkgs.nixfmt

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

    # Infrastructure
    pkgs.google-cloud-sdk
    pkgs.ssm-session-manager-plugin
    pkgs.terraform
    pkgs.tflint
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
