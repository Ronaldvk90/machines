{
  description = "NixOS config flaked";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  home-manager = {
    url = "github:nix-community/home-manager/release-26.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  nixos-generators = {
    url = "github:nix-community/nixos-generators";
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

  lanzaboote = {
    url = "github:nix-community/lanzaboote/v1.1.0";
    inputs.nixpkgs.follows = "nixpkgs";
    };
};

outputs = { self, nixpkgs, home-manager, disko, agenix, lanzaboote, nixos-generators, ... }:
#################################################################################


############### Virtual Machines ################################################
let
  flserver = { platformModules }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/desktop/xfce4.nix
        ./modules/desktop/fonts.nix
        ./modules/services/avahi.nix
        ./modules/services/pipewire.nix
        ./modules/services/ssh.nix
        ./modules/services/xrdp.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
      ] ++ platformModules;
    };

  test = { platformModules }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/services/ssh.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
      ] ++ platformModules;
    };

  jellyfin = { platformModules }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/services/jellyfin.nix
        ./modules/services/samba.nix
        ./modules/services/ssh.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
      ] ++ platformModules;
    };

  nextcloud = { platformModules }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/services/nextcloud.nix
        ./modules/services/ssh.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
      ] ++ platformModules;
    };
  
  outatime = { platformModules }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/services/podman.nix
        ./modules/services/ssh.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default        
      ] ++ platformModules;
    };

  transmission = { platformModules }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/sudo.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/services/ssh.nix
        ./modules/services/transmission.nix
        ./modules/services/zsh.nix
        ./modules/services/samba.nix
        ./modules/users/ronald.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default        
      ] ++ platformModules;
    };
in
{
#################################################################################

############### Output modules ##################################################
nixosConfigurations.pxeinstaller =
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      "${nixpkgs}/nixos/modules/installer/netboot/netboot-minimal.nix"
      ./installers/pxeinstaller/configuration.nix
    ];
  };

packages.x86_64-linux.nixos-pve-lxc =
  nixos-generators.nixosGenerate {
    system = "x86_64-linux";
    format = "proxmox-lxc";

    modules = [
      ./containers/pvelxc/configuration.nix
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

  nixosConfigurations.livexfce =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./liveenv/xfcelive/configuration.nix
      ];
    };
#################################################################################

############### Virtul Machine platform specific ################################
  nixosConfigurations = {
    flserver-qemu = flserver {
      platformModules = [
        ./modules/services/qemu-guest-agent.nix
        ./qemuvms/flserver/configuration.nix
        ./qemuvms/flserver/disk.nix
        disko.nixosModules.disko
      ];
    };

    flserver-incus = flserver {
      platformModules = [
        ./modules/services/incus-agent.nix
        ./incusvms/flserver/configuration.nix
        ./incusvms/flserver/incus.nix
      ];
    };

    test-qemu = test {
      platformModules = [
        ./modules/services/qemu-guest-agent.nix
        ./qemuvms/test/configuration.nix
        ./qemuvms/test/disk.nix
        disko.nixosModules.disko
      ];
    };

    test-incus = test {
      platformModules = [
        ./modules/services/incus-agent.nix
        ./incusvms/test/configuration.nix
        ./incusvms/test/incus.nix
      ];
    };

    jellyfin-qemu = jellyfin {
      platformModules = [
        ./modules/services/qemu-guest-agent.nix
        ./qemuvms/jellyfin/configuration.nix
        ./qemuvms/jellyfin/disk.nix
        disko.nixosModules.disko
      ];
    };

    jellyfin-incus = jellyfin {
      platformModules = [
        ./modules/services/incus-agent.nix
        ./incusvms/jellyfin/configuration.nix
        ./incusvms/jellyfin/incus.nix
      ];
    };

    nextcloud-qemu = nextcloud {
      platformModules = [
        ./modules/services/qemu-guest-agent.nix
        ./qemuvms/nextcloud/configuration.nix
        ./qemuvms/nextcloud/disk.nix
        disko.nixosModules.disko
      ];
    };

    nextcloud-incus = nextcloud {
      platformModules = [
        ./modules/services/incus-agent.nix
        ./incusvms/nextcloud/configuration.nix
        ./incusvms/nextcloud/incus.nix
      ];
    };

    outatime-qemu = outatime {
      platformModules = [
        ./modules/services/qemu-guest-agent.nix
        ./qemuvms/outatime/configuration.nix
        ./qemuvms/outatime/disk.nix
        disko.nixosModules.disko
      ];
    };

    outatime-incus = outatime {
      platformModules = [
        ./modules/services/incus-agent.nix
        ./incusvms/outatime/configuration.nix
        ./incusvms/outatime/incus.nix
      ];
    };

    transmission-qemu = transmission {
      platformModules = [
        ./modules/services/qemu-guest-agent.nix
        ./qemuvms/transmission/configuration.nix
        ./qemuvms/transmission/disk.nix
        disko.nixosModules.disko
      ];
    };

    transmission-incus = transmission {
      platformModules = [
        ./modules/services/incus-agent.nix
        ./incusvms/transmission/configuration.nix
        ./incusvms/transmission/incus.nix
      ];
    };
#################################################################################

############### Bare metal machines #############################################
  marty =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/binfmt.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/i2c.nix
        ./modules/core/sudo.nix
        ./modules/core/systemdboot.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/desktop/fonts.nix
        ./modules/desktop/gnome-keyring.nix
        ./modules/desktop/sway.nix
        ./modules/display-manager/greetd.nix
        ./modules/hardware/bluetooth.nix
        ./modules/services/1password.nix
        ./modules/services/avahi.nix
        ./modules/services/docker.nix
        ./modules/services/libvirt.nix
        ./modules/services/pipewire.nix
        ./modules/services/printing.nix
        ./modules/services/sabnzbd.nix
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

  biff =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/binfmt.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/i2c.nix
        ./modules/core/sudo.nix
        ./modules/core/systemdboot.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/desktop/fonts.nix
        ./modules/desktop/gnome-keyring.nix
        ./modules/desktop/sway.nix
        ./modules/display-manager/greetd.nix        
        ./modules/hardware/bluetooth.nix
        ./modules/services/1password.nix
        ./modules/services/avahi.nix
        ./modules/services/docker.nix
        ./modules/services/ifuse.nix
        ./modules/services/libvirt.nix
        ./modules/services/pipewire.nix
        ./modules/services/printing.nix
        ./modules/services/samba.nix
        ./modules/services/wireguard.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        ./hosts/biff/configuration.nix
        ./hosts/biff/disk.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        agenix.nixosModules.default
        lanzaboote.nixosModules.lanzaboote
        ];
      };

  werkplaats =
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
        ./modules/desktop/fonts.nix
        ./modules/desktop/gnome-keyring.nix
        ./modules/desktop/sway.nix
        ./modules/display-manager/greetd.nix        
        ./modules/services/1password.nix 
        ./modules/services/docker.nix
        ./modules/services/libvirt.nix
        ./modules/services/pipewire.nix
        ./modules/services/printing.nix
        ./modules/services/wireguard.nix
        ./modules/services/zsh.nix
        ./modules/users/ronald.nix
        ./hosts/werkplaats/configuration.nix
        ./hosts/werkplaats/disk.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        agenix.nixosModules.default
        ];
      };

  debbie =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/core/systemdboot.nix
        ./modules/core/common.nix
        ./modules/core/enable-flakes.nix
        ./modules/core/timezone.nix
        ./modules/core/unfree.nix
        ./modules/desktop/plasma.nix
        ./modules/display-manager/sddm.nix
        ./modules/hardware/bluetooth.nix
        ./modules/services/1password.nix
        ./modules/services/avahi.nix
        ./modules/services/onedrive.nix
        ./modules/services/pipewire.nix
        ./modules/services/printing.nix
        ./modules/users/debbie.nix
        ./hosts/debbie/configuration.nix
        ./hosts/debbie/disk.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        agenix.nixosModules.default
        ];
      };
  
  strickland =
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
    };
  };
}
