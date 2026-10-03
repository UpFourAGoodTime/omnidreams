{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.soteria = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs self;
    };
    modules = [
      inputs.self.nixosModules.soteria-config
    ];
  };

  flake.nixosModules.soteria-config =
    {
      pkgs,
      lib,
      config,
      modulesPath,
      ...
    }:
    # let
    #   pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    # in
    {

      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")

        inputs.self.nixosModules.host
        inputs.self.nixosModules.disko-ext4
        inputs.self.nixosModules.systemd-boot

        inputs.self.nixosModules.gabriele-config
      ];

      host = {
        hostName = "soteria";
      };

      programs.kdeconnect.enable = true;

      environment.systemPackages = [

        inputs.omniri.packages.${pkgs.stdenv.hostPlatform.system}.wallpapers

        pkgs.wget
        pkgs.git
      ];


      boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "uas" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

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
