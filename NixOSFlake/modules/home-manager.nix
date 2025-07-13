{ config, pkgs, ... }: {
  home-manager.users.nix = { 
    home.stateVersion = config.system.stateVersion;
    home.username = "nix";
    home.homeDirectory = "/home/nix";
    imports = [
      ./dotfiles/test.nix
      # ./dotfiles/hyprland.nix
    ];
  };
}