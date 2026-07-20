{
  description = "NixOS config flaked";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  home-manager = {
    url = "github:nix-community/home-manager/release-26.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  agenix = {
    url = "github:ryantm/agenix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = { self, nixpkgs, home-manager, disko, agenix, ... }: {
nixosConfigurations.pxeinstaller =
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      "${nixpkgs}/nixos/modules/installer/netboot/netboot-minimal.nix"
      ./installers/pxeinstaller/configuration.nix
    ];
  };

  nixosConfigurations.isoinstaller =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./installers/isoinstaller/configuration.nix
      ];
    };

  nixosConfigurations.marty =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/binfmt.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/systemdboot.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/crypto/secrets.nix
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
        ./modules/users/ronald.nix
        ./hosts/marty/configuration.nix
        ./hosts/marty/disk.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        agenix.nixosModules.default        
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
        ./modules/core/systemdboot.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/crypto/secrets.nix
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
        ./modules/users/ronald.nix
        ./hosts/biff/configuration.nix
        ./hosts/biff/disk.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        agenix.nixosModules.default
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
        ./modules/core/systemdboot.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/crypto/secrets.nix
        ./modules/desktop/fonts.nix
        ./modules/desktop/gnome-keyring.nix
        ./modules/desktop/sway.nix
        ./modules/services/1password.nix 
        ./modules/services/docker.nix
        ./modules/services/hypervisor.nix
        ./modules/services/pipewire.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        ./hosts/werkplaats/configuration.nix
        ./hosts/werkplaats/disk.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        agenix.nixosModules.default
      ];
    };

  nixosConfigurations.debbie =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/crypto/secrets.nix
        ./modules/desktop/plasma.nix
        ./modules/hardware/bluetooth.nix
        ./modules/hardware/printing.nix
        ./modules/services/1password.nix
        ./modules/services/avahi.nix
        ./modules/services/onedrive.nix
        ./modules/services/pipewire.nix
        ./modules/users/debbie.nix
        ./hosts/debbie/configuration.nix
        ./hosts/debbie/disk.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        agenix.nixosModules.default
      ];
    };
  
    nixosConfigurations.strickland =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/binfmt.nix
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/crypto/secrets.nix
        ./modules/hardware/zfs.nix
        ./modules/services/incus.nix
        ./modules/services/ssh.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        ./hosts/strickland/configuration.nix
        ./hosts/strickland/disk.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        agenix.nixosModules.default
      ];
    };

    nixosConfigurations.jellyfin =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/crypto/secrets.nix        
        ./modules/services/jellyfin.nix
        ./modules/services/samba.nix
        ./modules/services/ssh.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        ./incusvms/jellyfin/configuration.nix
        ./incusvms/jellyfin/incus.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
      ];
    };

    nixosConfigurations.outatime =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/crypto/secrets.nix
        ./modules/services/podman.nix
        ./modules/services/ssh.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        ./incusvms/outatime/configuration.nix
        ./incusvms/outatime/incus.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default        
      ];
    };

    nixosConfigurations.transmission =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nixos
        ./modules/crypto/secrets.nix        
        ./modules/services/ssh.nix
        ./modules/services/transmission.nix
        ./modules/services/zsh.nix
        ./modules/services/samba.nix
        ./modules/users/ronald.nix
        ./incusvms/transmission/configuration.nix
        ./incusvms/transmission/incus.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default        
      ];
    };
  };
}
