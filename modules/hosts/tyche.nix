{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.tyche = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = {
      inherit inputs self;
    };
    modules = [
      inputs.self.nixosModules.tyche-config
    ];
  };

  flake.nixosModules.tyche-config =
    {
      pkgs,
      lib,
      ...
    }:
    # let
    #   pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    # in
    {

      imports = [
        inputs.self.nixosModules.host
        inputs.self.nixosModules.disko-ext4
        inputs.self.nixosModules.systemd-boot
        inputs.self.nixosModules.security-config
        inputs.x1e-nixos-config.nixosModules.x1e

        inputs.self.nixosModules.gabriele-config
      ];

      host = {
        hostName = "tyche";
      };

      programs.kdeconnect.enable = true;

      environment.systemPackages = [

        inputs.omniri.packages.${pkgs.stdenv.hostPlatform.system}.wallpapers

        pkgs.wget
        pkgs.git
      ];

      hardware.asus-vivobook-s15.enable = true;

      nixpkgs.hostPlatform.system = "aarch64-linux";

      hardware.firmware = [
        pkgs.linux-firmware
        pkgs.ipw2200-firmware
        pkgs.rtl8192su-firmware
        pkgs.rt5677-firmware
        pkgs.rtl8761b-firmware
        pkgs.zd1211fw
        pkgs.alsa-firmware
        pkgs.sof-firmware
        pkgs.libreelec-dvb-firmware
      ];

      services.upower = {
        enable = true;
      };

      networking.networkmanager = {
        enable = true;
        plugins = lib.mkForce [ ];
      };

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
      };

      # Uncomment this to allow unfree packages.
      # nixpkgs.config.allowUnfree = true;

      nix = {
        channel.enable = false;
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
}
