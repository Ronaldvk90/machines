{ config, pkgs, lib, ... }:

{
  home.username = "ronald";
  home.homeDirectory = "/home/ronald";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    nerd-fonts.hack
  ];

  xdg.configFile."oh-my-posh/easy-term.omp.json".source = ./configs/zsh/easy-term.omp.json;

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    PODMAN_COMPOSE_WARNING_LOGS = "false";
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = "${config.xdg.configHome}/oh-my-posh/easy-term.omp.json";
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number relativenumber
      set mouse=a
    '';
    plugins = [
      pkgs.vimPlugins.nvim-tree-lua
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
  initContent = ''
    bindkey "^[[1;3D" backward-word
    bindkey "^[[1;3C" forward-word
    bindkey  "^[[H"   beginning-of-line
    bindkey  "^[[F"   end-of-line

    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt appendhistory
  '';
  };
 
  programs.git = {
    package = pkgs.git;
    enable = true;
      settings = {
        user.name = "Ronald van Kouwen";
	      user.email = "Ronaldvk90@outlook.com";
	      url."git@github.com:".insteadOf = "https://github.com/";
      };
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
  };

  programs.tmate = {
    enable = true;
  };
  
  programs.home-manager.enable = true;
}
{ config, pkgs, lib, ... }:

{ 
  home.username = "ronald";
  home.homeDirectory = "/home/ronald";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    nerd-fonts.hack
  ];

  home.file = {
    ".tmux.conf".source = ./configs/tmux/tmux.conf;
  };

  xdg.configFile."oh-my-posh/easy-term.omp.json".source = ./configs/zsh/easy-term.omp.json;

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    PODMAN_COMPOSE_WARNING_LOGS = "false";
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = "${config.xdg.configHome}/oh-my-posh/easy-term.omp.json";
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number relativenumber
      set mouse=a
    '';
    plugins = [
      pkgs.vimPlugins.nvim-tree-lua
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
  initContent = ''
    bindkey "^[[1;3D" backward-word
    bindkey "^[[1;3C" forward-word
    bindkey  "^[[H"   beginning-of-line
    bindkey  "^[[F"   end-of-line

    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt appendhistory
  '';
  };
 
  programs.git = {
    package = pkgs.git;
    enable = true;
    #settings.user.name = "Ronald van Kouwen";
    #settings.user.email = "ronaldvk90@outlook.com";
      settings = {
        user.name = "Ronald van Kouwen";
	      user.email = "Ronaldvk90@outlook.com";
	      url."git@github.com:".insteadOf = "https://github.com/";
      };
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
  };

  programs.tmate = {
    enable = true;
  };

  programs.home-manager.enable = true;
}