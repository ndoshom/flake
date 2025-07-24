{pkgs}: let
  add-service = import ./add-service.nix {inherit pkgs;};
  start-tmux = import ./start-tmux.nix { inherit pkgs;};
in {
  inherit (add-service) addService;
  inherit (start-tmux) startTmux;
}
