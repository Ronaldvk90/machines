{ config, pkgs, lib, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."debbie" = {
    isNormalUser = true;
    description = "Debbie Berendsen";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  
}