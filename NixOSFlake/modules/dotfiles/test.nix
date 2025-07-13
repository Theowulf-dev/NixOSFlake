{ config, pkgs, ... }: {
# Test config file
  home.file.".config/test.conf".text = ''
test
  '';
}