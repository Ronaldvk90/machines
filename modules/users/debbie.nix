{ config, pkgs, lib, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."debbie" = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.debbiePassword.path;
    description = "Debbie Berendsen";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}