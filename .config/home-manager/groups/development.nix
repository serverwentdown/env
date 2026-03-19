{
  config,
  pkgs,
  lib,
  ...
}:

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

    # Emulation
    (pkgs.qemu.override { toolsOnly = true; })

    # Containers
    pkgs.docker-client
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

    # Language servers
    pkgs.nil
  ];

  home.file = {
  };

  home.sessionVariables = {
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
    dockerPackage = pkgs.docker-client;
    profiles.default = {
      isActive = true;
      isService = true;
      setDockerHost = true;
      settings = {
        cpu = 4;
        disk = 200;
        memory = 6;
        kubernetes = {
          enabled = false;
          version = "v1.35.2+k3s1";
          k3sArgs = [ ];
        };
        network = {
          dnsHosts = {
            "host.docker.internal" = "host.lima.internal";
          };
        };
        forwardAgent = true;
        docker = {
          features = {
            buildkit = true;
            containerd-snapshotter = true;
          };
        };
        vmType = lib.mkDefault "qemu";
        rosetta = lib.mkDefault false;
        mountType = lib.mkDefault "virtiofs";
        mountInotify = true;
        provision = [
          {
            mode = "system";
            script = ''
              set -ex
              apt-get update
              apt-get install -y htop iotop iputils-ping strace
            '';
          }
          {
            mode = "system";
            script = ''
              set -ex
              DUST_VERSION=v1.2.4
              DUST_TARGET=$(uname -m)-unknown-linux-gnu
              wget \
                --output-document /tmp/dust.tar.gz \
                https://github.com/bootandy/dust/releases/download/''${DUST_VERSION}/dust-''${DUST_VERSION}-''${DUST_TARGET}.tar.gz
              tar -xvf /tmp/dust.tar.gz \
                --strip-components=1 \
                --directory=/usr/local/bin \
                dust-''${DUST_VERSION}-''${DUST_TARGET}/dust
              rm /tmp/dust.tar.gz
            '';
          }
        ];
      };
    };
  };

  # Infrastructure
  programs.awscli.enable = true;
}
