{
  description = "Chenfei nix-darwin system flake";

  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-linux.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    agenix.url = "github:ryantm/agenix";
    catppuccin.url = "github:catppuccin/nix";
    yazi.url = "github:sxyazi/yazi";

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
    bun = {
      url = "github:oven-sh/homebrew-bun";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs-darwin,
      nixpkgs-linux,
      nixpkgs-unstable,
      nix-darwin,
      home-manager,
      ...
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
        pkgs = import nixpkgs-darwin {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        specialArgs = {
          inherit
            inputs
            outputs
            user
            email
            ;
          pkgs-unstable = import inputs.nixpkgs-unstable {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/mac-ycf/configuration.nix
          ./darwinModules
        ];
      };

      homeConfigurations."ubuntu-ycf" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs-linux {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit
            inputs
            outputs
            user
            email
            ;
          pkgs-unstable = import inputs.nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [ ./hosts/ubuntu-ycf/home.nix ];
      };

      homeManagerModules.default = ./homeManagerModules;
    };
}
