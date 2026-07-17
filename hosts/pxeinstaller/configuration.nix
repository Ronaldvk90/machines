{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFydz8KQpnXaXFtUijJdQtub7XyUB0rQSZEA2eAuXqsP"
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    tmux
    disko
    cifs-utils
    nfs-utils
  ];
}