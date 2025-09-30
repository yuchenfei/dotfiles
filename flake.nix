{
  description = "Chenfei nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    catppuccin.url = "github:catppuccin/nix";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-extras = {
      url = "github:brewforge/homebrew-extras";
      flake = false;
    };
    im-select = {
      url = "github:daipeihust/homebrew-tap";
      flake = false;
    };
    airbattery = {
      url = "github:lihaoyun6/homebrew-tap";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      catppuccin,
      homebrew-core,
      homebrew-cask,
      homebrew-extras,
      im-select,
      airbattery,
    }@inputs:
    let
      user = "yuchenfei";
      email = "cf.yu@qq.com";
      inherit (self) outputs;
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#MAC-YCF
      darwinConfigurations."MAC-YCF" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs outputs user; };
        modules = [
          ./darwin.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              inherit user;
              enable = true;
              enableRosetta = true; # Apple Silicon Only
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "brewforge/homebrew-extras" = homebrew-extras;
                "daipeihust/homebrew-tap" = im-select;
                "lihaoyun6/homebrew-tap" = airbattery;
              };
              autoMigrate = true;
              mutableTaps = false;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit user email; };
              users.${user} = {
                imports = [
                  ./home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
            };
          }
        ];
      };
    };
}
