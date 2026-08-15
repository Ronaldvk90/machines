{
  age.identityPaths = [
    "/var/lib/agenix/agenix.key"
  ];

  nixpkgs.config.allowUnfree = true;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  users.mutableUsers = false;
}
