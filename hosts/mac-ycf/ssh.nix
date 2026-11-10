# References:
# - https://github.com/nix-community/home-manager/blob/master/modules/programs/ssh.nix
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
    settings = {
      "*" = {
        addKeysToAgent = "yes";
        controlMaster = "auto";
        controlPersist = "10m";
        forwardAgent = false;
        identitiesOnly = true;
        serverAliveInterval = 60;
        UseKeychain = "yes";
      };
      "github.com ssh.github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
        identityFile = config.age.secrets.github.path;
      };
      immortalwrt = {
        hostname = "immortalwrt";
        user = "root";
        identityFile = config.age.secrets.home.path;
      };
      immortalwrt-lan = {
        hostname = "immortalwrt.lan";
        user = "root";
        identityFile = config.age.secrets.home.path;
      };
      tower = {
        hostname = "tower";
        user = "root";
        identityFile = config.age.secrets.home.path;
      };
      tower-lan = {
        hostname = "tower.lan";
        user = "root";
        identityFile = config.age.secrets.home.path;
      };
      ubuntu = {
        hostname = "ubuntu-ycf.lan";
        user = "yuchenfei";
        identityFile = config.age.secrets.home.path;
      };
      voron = {
        hostname = "voron.lan";
        user = "yuchenfei";
        identityFile = config.age.secrets.home.path;
      };
    };
  };
}
