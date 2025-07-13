{ config, pkgs, ... }: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Add compression to Swap.
  zramSwap.enable = true;
}