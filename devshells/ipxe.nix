{ pkgs }:

pkgs.mkShell {
  # Packages to use for iPXE
  packages = with pkgs; [
    gcc
    binutils
    perl
    xz
    mtools
    cdrtools
    syslinux
    gnumake
    autoconf
    git
    zsh
  ];

  # Env variables IF nescesary
  #RANDOM_ENV = "BLA";

  # ShellHooks. Things to start when entering the dev shell
  shellHook = ''
    echo "iPXE dev shell"
    exec zsh
  '';
}