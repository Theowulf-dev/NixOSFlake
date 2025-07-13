{ config, pkgs, ... }: {
  home-manager.users.nix = { 
    home.stateVersion = config.system.stateVersion;
    home.username = "nix";
    home.homeDirectory = "/home/nix";
    imports = [
      ./dotfiles/hyprland-config.nix
    ];
	
	xdg.mimeApps.defaultApplications = {
	  "text/plain" = [ "notepadqq.desktop" ];
	};
  };
}