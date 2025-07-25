{
  config,
  pkgs,
  inputs,
  ...
}: let
  scripts = import ./scripts/default.nix {inherit pkgs;};
in {
  home.username = "ns";
  home.homeDirectory = "/home/ns";
  home.stateVersion = "25.11";

  home.packages = with pkgs;
    (lib.attrValues scripts)
    ++ [
      btop
      helix
      fish
      zoxide
      gimp
      hyprshot
      yazi
      lazygit
      hyprland
    ];


  programs.home-manager.enable = true;
}
