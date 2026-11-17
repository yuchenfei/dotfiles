{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin.autoEnable = true;
  catppuccin.enable = true;
}
