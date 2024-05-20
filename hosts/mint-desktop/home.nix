{ pkgs, ... }: 

{
  # Define packages to be installed
  environment.systemPackages = with pkgs; [
    vscode
    alacritty
    discord
  ];

  home.username = "pedro";
  home.homeDirectory = "/home/pedro";
}
