{ config, pkgs, ... }: {
  # Enable the X11/Wayland windowing system.
  services.xserver.enable = true;
  
  # Enable AMD Drivers.
  # services.xserver.videoDrivers = [ "amdgpu" ]
  
  # Enable Hyprland.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  # Enable Login
  services.displayManager.ly.enable = true;
  
  # Enable USB support on Hyprland
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}