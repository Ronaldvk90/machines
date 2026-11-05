{ pkgs }:

pkgs.mkShell {
  # Packages to use for iPXE
  packages = with pkgs; [
    make
    autoconf
  ];

  # Env variables IF nescesary
  #RANDOM_ENV = "BLA";

  # ShellHooks. Things to start when entering the dev shell
  shellHook = ''
  echo "lik mijn anus!"
  '';
}