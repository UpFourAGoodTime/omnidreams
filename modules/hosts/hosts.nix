{
  ...
}:
{
  flake.nixosModules.host =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      cfg = config.host;
    in
    {
      options.host = {
        hostName = lib.mkOption {
          type = lib.types.str;
          default = "nixos";
        };

        allowUnfree = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        i18n-defaultLocale = lib.mkOption {
          type = lib.types.str;
          default = "en_US.UTF-8";
        };

      };

      config = {

        environment.systemPackages = [
          pkgs.libsecret
        ];

        boot.kernelParams = [
          # Supposed Linux local privilege escalation using this module:
          # https://copy.fail/
          "module_blacklist=algif_aead"
          # Linux local privilege escalation using esp4, esp6, rxrpc:
          # https://github.com/V4bel/dirtyfrag
          "module_blacklist=algif_aead,esp4,esp6,rxrpc"
        ];

        networking.hostName = cfg.hostName;

        # Allow unfree packages
        nixpkgs.config.allowUnfree = cfg.allowUnfree;

        # Enable networking
        networking.networkmanager.enable = true;
        hardware.bluetooth.enable = true;

        # Set your time zone.
        time.timeZone = lib.mkDefault "America/Chicago";

        # Select internationalisation properties.
        i18n.defaultLocale = cfg.i18n-defaultLocale;

        i18n.extraLocaleSettings = {
          LC_ADDRESS = cfg.i18n-defaultLocale;
          LC_IDENTIFICATION = cfg.i18n-defaultLocale;
          LC_MEASUREMENT = cfg.i18n-defaultLocale;
          LC_MONETARY = cfg.i18n-defaultLocale;
          LC_NAME = cfg.i18n-defaultLocale;
          LC_NUMERIC = cfg.i18n-defaultLocale;
          LC_PAPER = cfg.i18n-defaultLocale;
          LC_TELEPHONE = cfg.i18n-defaultLocale;
          LC_TIME = cfg.i18n-defaultLocale;
        };

        #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

        # Configure network proxy if necessary
        # networking.proxy.default = "http://user:password@proxy:port/";
        # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

        # To search, run:
        # $ nix search wget

        networking.firewall.enable = true;
        nix.settings.trusted-users = [ "@wheel" ];

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        environment.variables = {
          NIX_SSHOPS = "-t";
          EDITOR = "nano";
          # For multi-value variables like PATH, use a Nix list
          PATH = [
            "/usr/local/bin"
            "$PATH" # Include existing PATH
          ];
          ZED_ALLOW_ROOT = "true";
          PASSWORD_STORE_DIR = "gnome-libsecret";
        };

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;

        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        # programs.mtr.enable = true;
        # programs.gnupg.agent = {
        #   enable = true;
        #   enableSSHSupport = true;
        # };

        # List services that you want to enable:

        # Open ports in the firewall.
        # networking.firewall.allowedTCPPorts = [ ... ];
        # networking.firewall.allowedUDPPorts = [ ... ];
        # Or disable the firewall altogether.
        # networking.firewall.enable = false;

        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = "26.11";

      };

    };
}
