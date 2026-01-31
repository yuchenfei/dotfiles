{
  description = "Chenfei nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
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
      nixpkgs-unstable,
      nix-darwin,
      ...
    }@inputs:
    let
      user = "yuchenfei";
      email = "cf.yu@qq.com";
      inherit (self) outputs;
      # Configure unstable pkgs for mixed usage
      pkgs-unstable = import nixpkgs-unstable {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#MAC-YCF
      darwinConfigurations."MAC-YCF" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit
            inputs
            outputs
            user
            email
            pkgs-unstable
            ;
        };
        modules = [
          ./hosts/mac-ycf/configuration.nix
          ./darwinModules
        ];
      };

      homeManagerModules.default = ./homeManagerModules;
    };
}
