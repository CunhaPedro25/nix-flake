{ config, pkgs, ... }: 

{
  home.username = "pedro";
  home.homeDirectory = "/home/pedro";
  home.stateVersion = "23.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fish
    starship
    neofetch
    uwufetch
  ];

  programs.home-manager.enable = true;

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        # Start starship
        starship init fish | source
      '';
    };
  };
}

