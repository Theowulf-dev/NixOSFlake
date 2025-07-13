{ config, pkgs, ... }: {
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;
  
  # Install Steam
  programs.steam = {
  enable = true;
  gamescopeSession.enable = true;
  };
  
  programs.gamemode.enable = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable Flatpak.
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  
  # Enable Appimage.
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  
  # Enable Docker.
  virtualisation.docker.enable = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix!
  # The Nano editor is installed by default.
  # To add pkgs from unstable version of NixOS use
  # unstable.btop
  
  # GUI
  blender
  bottles
  brave
  cameractrls
  davinci-resolve
  discord
  godot
  gnome-disk-utility
  gnome-boxes
  gnome-system-monitor
  gitkraken
  motrix
  obs-studio
  obsidian
  inkscape
  jetbrains.rider
  jetbrains.rust-rover
  notepadqq
  krita
  telegram-desktop
  
  # CLI
  wget
  btop
  git
  flatpak
  compsize
  nh
  nnn
  
  # Archive manager
  file-roller # I should replace with TauArchivMeister
  p7zip
  unrar
  unzip
  xz
  gzip
  lrzip
  
  # Sceenshot tools should make my own.
  grim
  slurp
  swappy
  
  # Packages bellow are for Hyprland
  swaynotificationcenter
  libnotify
  hyprpaper # I should replace this for Paralax Wallpaper
  kitty
  rofi-wayland # I should replace this for TauAppKorb
  nautilus # I should replace this for TauFileManager
  bibata-cursors # I should replace with TauCursors
  hyprpolkitagent
  
  # These scripts bellow are added as terminal commands.
  (writeShellScriptBin "nixos-edit" ''
      sudo nano $HOME/Documents/Obsidian/NixOSFlake/configuration.nix
    '') # Opens configuration.nix in nano
  (writeShellScriptBin "nixos-edit-gui" ''
      notepadqq $HOME/Documents/Obsidian/NixOSFlake/configuration.nix
    '') # Opens configuration.nix in notepadqq
    (writeShellScriptBin "nixos-rebuild-flake" ''
      nh os switch "$HOME/Documents/Obsidian/NixOSFlake"#nixos
    '') # Build my flake from Obsidian folder.
  ];
  
  # Remove packages.
  services.xserver.excludePackages = [ pkgs.xterm ];
}