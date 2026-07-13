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
        ./hosts/marty/configuration.nix
	./modules/common.nix
	home-manager.nixosModules.home-manager
      ];
    };

  nixosConfigurations.biff =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
	./modules/common.nix
	./hosts/biff/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

  nixosConfigurations.werkplaats =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/common.nix
        ./hosts/werkplaats/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

  nixosConfigurations.debbie =
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./modules/common.nix
        ./hosts/debbie/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
