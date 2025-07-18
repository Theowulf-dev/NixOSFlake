{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, rust-overlay, home-manager, winapps, ... } @ inputs:
    let
      system = "x86_64-linux";

      overlays = [ (import rust-overlay) ];

      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;

    in {
      packages = {
        ${system} = {
          nixos = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs unstable; };
            modules = [
              home-manager.nixosModules.home-manager
              ./configuration.nix
            ];
          };
        };
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs unstable; };
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };

      devShells.${system}.rust = pkgs.mkShell {
        name = "rust-dev";

        buildInputs = [
          rustToolchain
          pkgs.jetbrains.rust-rover
          pkgs.rust-analyzer
          pkgs.rustup # Need to run rustup install stable
          pkgs.clippy
          pkgs.rustfmt
          pkgs.lldb
          pkgs.pkg-config
          pkgs.openssl
          pkgs.wayland
          pkgs.wlroots
        ];

        shellHook = ''
          export XDG_SESSION_TYPE=wayland
          echo "Rust dev shell with RustRover ready"
        '';
      };
    };
}