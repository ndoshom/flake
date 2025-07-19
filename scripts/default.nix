{pkgs}: let
  add-service = import ./add-service.nix {inherit pkgs;};
in {
  inherit (add-service) addService;
}
