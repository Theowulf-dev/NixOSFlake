{ config, pkgs, unstable, ... }: {
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
  
  # Enable virtualisation.
  virtualisation.libvirtd.enable = true;
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-ocl
      intel-media-driver
      intel-gpu-tools
      vpl-gpu-rt
      intel-vaapi-driver
    ];
  };
  
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
  kvmtool
  gnome-system-monitor
  gitkraken
  motrix
  obs-studio
  obsidian
  inkscape
  ladybird
  notepadqq
  # nexusmods-app-unfree
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
  
  # Development
  (makeDesktopItem {
          name = "rust-rover-dev-shell";
          desktopName = "Rust Rover (Shell)";
          genericName = "Integrated Development Environment";
          comment = "Run Rust Rover inside a dev shell";
          icon = "rust-rover";
          exec = "${pkgs.writeShellScript "rust-rover-dev-shell" ''
          nix develop /home/nix/Documents/Obsidian/NixOSFlake#rust --command rust-rover
          ''}";
          categories = [ "Development" "IDE" ];
          startupNotify = true;
        })
  
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