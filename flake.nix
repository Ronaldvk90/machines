{
  description = "NixOS config flaked";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  home-manager = {
    url = "github:nix-community/home-manager/release-26.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = { self, nixpkgs, home-manager, ... }: {
  nixosConfigurations.marty =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/binfmt.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/desktop/fonts.nix
        ./modules/desktop/gnome-keyring.nix
        ./modules/desktop/sway.nix
        ./modules/hardware/bluetooth.nix
        ./modules/hardware/printing.nix
        ./modules/services/1password.nix
        ./modules/services/avahi.nix
        ./modules/services/docker.nix
        ./modules/services/hypervisor.nix
        ./modules/services/pipewire.nix
        ./modules/services/samba.nix
        ./modules/services/zsh.nix
        ./hosts/marty/configuration.nix
        ./hosts/marty/hardware-configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

  nixosConfigurations.biff =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/binfmt.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/desktop/fonts.nix
        ./modules/desktop/gnome-keyring.nix
        ./modules/desktop/sway.nix
        ./modules/hardware/bluetooth.nix
        ./modules/hardware/printing.nix
        ./modules/services/1password.nix
        ./modules/services/avahi.nix
        ./modules/services/docker.nix
        ./modules/services/hypervisor.nix
        ./modules/services/pipewire.nix
        ./modules/services/samba.nix
        ./modules/services/zsh.nix
        ./hosts/biff/configuration.nix
        ./hosts/biff/hardware-configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

  nixosConfigurations.werkplaats =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/binfmt.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/desktop/fonts.nix
        ./modules/desktop/gnome-keyring.nix
        ./modules/desktop/sway.nix
        ./modules/services/1password.nix 
        ./modules/services/docker.nix
        ./modules/services/hypervisor.nix
        ./modules/services/pipewire.nix
        ./modules/services/zsh.nix
        ./hosts/werkplaats/configuration.nix
        ./hosts/werkplaats/hardware-configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

  nixosConfigurations.debbie =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/desktop/plasma.nix
        ./modules/hardware/bluetooth.nix
        ./modules/hardware/printing.nix
        ./modules/services/1password.nix
        ./modules/services/avahi.nix
        ./modules/services/onedrive.nix
        ./modules/services/pipewire.nix
        ./hosts/debbie/configuration.nix
        ./hosts/debbie/hardware-configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
