{ config, pkgs, ... }: {
  users.users.nix = {
    isNormalUser = true;
    description = "NixOS";
    extraGroups = [ "networkmanager" "audio" "wheel" "docker" "podman" ];
  };
}