{
  ...
}:
{
  flake.nixosModules.mySddm =
    {
      pkgs,
      ...
    }:
    {

      environment.systemPackages = [
        pkgs.sddm-astronaut
      ];

      services.displayManager.sddm = {
        theme = "sddm-astronaut-theme";
        extraPackages = [ pkgs.sddm-astronaut ];
      };
    };
}
