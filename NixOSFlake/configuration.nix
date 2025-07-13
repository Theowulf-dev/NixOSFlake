{ config, pkgs, inputs, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/boot.nix
      ./modules/networking.nix
      ./modules/locale.nix
      ./modules/input.nix
      ./modules/audio.nix
      ./modules/users.nix
      ./modules/automation.nix
      ./modules/hyprland.nix
      ./modules/packages.nix
      ./modules/home-manager.nix
    ];
  
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "25.05";

}
