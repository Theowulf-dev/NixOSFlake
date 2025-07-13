{ config, pkgs, ... }: {
  services.libinput.enable = true;
  services.libinput.touchpad = {
    tapping = true;
    scrollMethod = "twofinger";
    middleEmulation = true;
  };
}