{
  inputs,
  ...
}:
{
  flake.nixosModules.gabriele-config =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager

        inputs.self.nixosModules.waydroid

        inputs.stylix.nixosModules.stylix
        inputs.omniri.nixosModules.default
        inputs.self.nixosModules.mySddm
      ];

      stylix = {
        enable = true;
      };

      stylix.cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 20;
      };

      stylix.opacity = {
        terminal = 0.8;
      };

      stylix.fonts = {
        monospace = {
          package = pkgs.roboto-mono;
          name = "Roboto Mono";
        };

        sansSerif = {
          package = pkgs.roboto-serif;
          name = "Roboto Serif";
        };
        serif = {
          package = pkgs.roboto-serif;
          name = "Roboto Serif";
        };
      };

      stylix.image = "${
        inputs.omniri.packages.${pkgs.stdenv.hostPlatform.system}.wallpapers
      }/share/wallpapers/wallhaven-k81776_2880x1620.png";

      # Syncthing
      networking.firewall.allowedTCPPorts = [
        8384
        22000
        21027
      ];

      users.users."gabriele" = {
        createHome = true;
        description = "Gabriel Eaker";
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
          "syncthing"
          # "qemu-libvirtd"
          # "libvirtd"
        ];
        isNormalUser = true;
        home = "/home/gabriele";
      };

      programs.chromium = {
        homepageLocation = "about:blank";
        defaultSearchProviderEnabled = true;
        defaultSearchProviderSearchURL = "https://www.qwant.com/?q={searchTerms}";
        extraOpts = {
          "BrowserGuestModeEnabled" = false;
          "AdvancedProtectionAllowed" = false;
          "BrowserSignin" = 0;
          "SyncDisabled" = true;
          "AutofillAddressEnabled" = false;
          "AutofillCreditCardEnabled" = false;
          "HappyEyeballsV3Enabled" = true;

          "SpellcheckEnabled" = true;
          "SpellcheckLanguage" = [
            "en-US"
          ];

          "AdsSettingForIntrusiveAdsSites" = 2;

        };

      };

      home-manager.extraSpecialArgs = { inherit inputs; };

      home-manager.backupCommand = "echo 'home-manager: skipped backing up a config file'";

      nixpkgs.config.allowUnfree = true;

      home-manager.users.gabriele = inputs.self.homeConfigurations."gabriele";
    };

  flake.homeConfigurations.gabriele =
    {
      inputs,
      pkgs,
      lib,
      ...
    }:
    let
      # pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};

      # Create a customized version of logseq
      logseq-patch = pkgs.logseq.override {
        electron_39 = pkgs.electron_40;
      };
    in
    {
      imports = [
        inputs.omniri.homeModules.default

        inputs.self.homeModules.chromium
      ];

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;

      home = {
        stateVersion = "26.05";

        username = "gabriele";
        homeDirectory = "/home/gabriele";

        sessionVariables = {
          EDITOR = "nano";
        };

      };

      nix.settings = {
        download-buffer-size = 524288000;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      nixpkgs.config.allowUnfree = true;

      stylix.enable = true;

      stylix.targets = {
        desktop-entries-stylix = {
          enable = true;

          entries = {
            pear-desktop.enable = true;

            element-desktop.enable = true;

            chromium-browser = {
              enable = true;

              package = pkgs.ungoogled-chromium;
            };
          };
        };
      };

      services.syncthing = {
        enable = true;

        settings = {
          gui = {
            user = "admin";
            password = "%qz&w!fcRsPqwGDD0BkAuDDrcVEsQ!7k^mSe$d0eHbyGyrEEz@4tDRGqp5Vg*&Ed"; # This is insecure, consider this password compromised when setting up Sops-Nix
          };

          devices = {
            "Pixel 8 Pro" = {
              id = "XOXMDLP-SBCERI5-6Q6I2GK-I4QUWDS-OPPOC3N-65CL6LS-N7P4C7S-EP22NAZ";
            };

            "Karen Pixel 7" = {
              id = "X4JOUCU-7U3JH3D-X4YKI5K-EZADLC3-3YW5FSP-X3NCACC-RVO2TYJ-AQHKPQ6";
            };

          };

          folders = {
            "Downloads" = {
              path = "/home/gabriele/Downloads";
              devices = [ "Pixel 8 Pro" ];
            };

            "Documents" = {
              path = "/home/gabriele/Documents";
              devices = [ "Pixel 8 Pro" ];
            };

            "Pictures" = {
              path = "/home/gabriele/Pictures";
              devices = [ "Pixel 8 Pro" ];
            };

            "DCIM" = {
              path = "/home/gabriele/DCIM";
              devices = [ "Pixel 8 Pro" ];
            };

            "Seedvault Pixel 8 Pro" = {
              path = "/home/gabriele/Seedvaults/Pixel-8-Pro";
              devices = [ "Pixel 8 Pro" ];
            };

            "Seedvault Karen Pixel 7" = {
              path = "/home/gabriele/Seedvaults/not-mine/Karen-Pixel-7";
              devices = [ "Karen Pixel 7" ];
            };

          };

        };

      };

      home.packages = [
        pkgs.freetube
        pkgs.zed-editor
        pkgs.element-desktop

        pkgs.localsend

        logseq-patch
        pkgs.anki

        pkgs.obs-studio
        pkgs.vlc

        pkgs.prismlauncher

        pkgs.zed-editor
        pkgs.nh
        pkgs.nixd
        pkgs.nil

        pkgs.fastfetch

        # pkgs.python312Packages.yt-dlp

      ];

      xdg.desktopEntries = {

        "syncthing-ui" = {
          name = "Syncthing Web UI";
          noDisplay = true;
        };

      };

      home.file = {
        ".config/niri-stylix/user-config.kdl".text = ''

          layout {
            background-color "transparent"
          }

          layer-rule {
            match namespace="wallpaper"
            place-within-backdrop true
          }

          window-rule {
          match app-id="dev.zed.Zed"
            background-effect {
               blur true
            }
          }

          window-rule {
          match app-id="Alacritty"
            background-effect {
               blur true
            }
          }

          window-rule {
            match title="Picture in picture"

            open-floating true
          }
        '';

      };

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
      };

      programs.git = {
        enable = true;
        settings = {
          user.name = "UpFourAGoodTime";
          user.email = "GabrielEaker@pm.me";
          init.defaultBranch = "main";
        };
      };

    };
}
