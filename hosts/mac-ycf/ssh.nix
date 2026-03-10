# References:
# - https://github.com/nix-community/home-manager/blob/release-25.11/modules/programs/ssh.nix
# - https://man.openbsd.org/ssh_config

{ config, ... }:
{
  age = {
    secrets = {
      sshPrivateConfig = {
        file = ../../secrets/ssh-private-config.age;
        path = "${config.home.homeDirectory}/.ssh/ssh-private-config";
      };
      github = {
        file = ../../secrets/github.age;
        path = "${config.home.homeDirectory}/.ssh/github";
      };
      home = {
        file = ../../secrets/home.age;
        path = "${config.home.homeDirectory}/.ssh/home";
      };
      server = {
        file = ../../secrets/server.age;
        path = "${config.home.homeDirectory}/.ssh/server";
      };
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      "~/.orbstack/ssh/config"
      config.age.secrets.sshPrivateConfig.path
    ];
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        controlMaster = "auto";
        controlPersist = "10m";
        forwardAgent = false;
        identitiesOnly = true;
        serverAliveInterval = 60;
        extraOptions = {
          UseKeychain = "yes";
        };
      };
      "github.com" = {
        user = "git";
        identityFile = config.age.secrets.github.path;
      };
      router = {
        hostname = "immortalwrt.local";
        user = "root";
        identityFile = config.age.secrets.home.path;
      };
      tower = {
        hostname = "tower.local";
        user = "root";
        identityFile = config.age.secrets.home.path;
      };
      ubuntu = {
        hostname = "ubuntu-ycf.local";
        user = "yuchenfei";
        identityFile = config.age.secrets.home.path;
      };
    };
  };
}
