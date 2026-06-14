{
  inputs,
  ...
}:
{
  flake.nixosModules.gabriele-config =
    {
      pkgs,
      lib,
      config,
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

      stylix.targets = {
        plymouth.enable = false;
        kmscon.enable = false;
      };

      stylix.cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 20;
      };

      stylix.fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
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

      home-manager.extraSpecialArgs = { inherit inputs; };

      home-manager.backupCommand = "echo 'home-manager: skipped backing up a config file'";

      nixpkgs.config.allowUnfree = true;

      home-manager.users.gabriele = inputs.self.homeConfigurations."gabriele";
    };

  flake.homeConfigurations.gabriele =
    {
      inputs,
      pkgs,
      ...
    }:
    let
      # pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};

      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};

      # Create a customized version of logseq
      logseq-patch = pkgs-unstable.logseq.override {
        electron_39 = pkgs-unstable.electron_40;
      };
    in
    {
      imports = [
        inputs.omniri.homeModules.default
      ];

      home.username = "gabriele";
      home.homeDirectory = "/home/gabriele";

      home.stateVersion = "26.05";

      nixpkgs.config.allowUnfree = true;

      stylix.enable = true;

      services.syncthing = {
        enable = true;

        settings = {
          gui = {
            user = "admin";
            password = "adminPassword";
          };

          devices = {
            "Pixel 6 Pro" = {
              id = "BRJFJAB-XPSAVIJ-BMES6UA-SH76SEF-SHCVKH6-Q5KNMNZ-QS6GONV-PZPLKQA";
            };

            "Karen Pixel 7" = {
              id = "X4JOUCU-7U3JH3D-X4YKI5K-EZADLC3-3YW5FSP-X3NCACC-RVO2TYJ-AQHKPQ6";
            };

          };

          folders = {
            "Downloads" = {
              path = "/home/gabriele/Downloads";
              devices = [ "Pixel 6 Pro" ];
            };

            "Documents" = {
              path = "/home/gabriele/Documents";
              devices = [ "Pixel 6 Pro" ];
            };

            "Pictures" = {
              path = "/home/gabriele/Pictures";
              devices = [ "Pixel 6 Pro" ];
            };

            "DCIM" = {
              path = "/home/gabriele/DCIM";
              devices = [ "Pixel 6 Pro" ];
            };

            "Seedvault Pixel 6 Pro" = {
              path = "/home/gabriele/Seedvaults/Pixel-6-Pro";
              devices = [ "Pixel 6 Pro" ];
            };

            "Seedvault Karen Pixel 7" = {
              path = "/home/gabriele/Seedvaults/not-mine/Karen-Pixel-7";
              devices = [ "Karen Pixel 7" ];
            };

          };

        };

      };

      home.packages = [
        pkgs-unstable.ungoogled-chromium
        pkgs-unstable.freetube
        pkgs-unstable.zed-editor
        pkgs-unstable.session-desktop

        pkgs-unstable.localsend

        logseq-patch
        pkgs-unstable.anki

        pkgs-unstable.obs-studio
        pkgs-unstable.vlc

        pkgs-unstable.prismlauncher

        pkgs.nh
        pkgs-unstable.nixd
        pkgs-unstable.nil

        pkgs-unstable.nerd-fonts.jetbrains-mono
        pkgs-unstable.nerd-fonts.hasklug
        pkgs-unstable.nerd-fonts.hurmit

        # pkgs.python312Packages.yt-dlp

      ];

      home.sessionVariables = {
        # QT_QPA_PLATFORMTHEME = "gtk3";
        # QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
      };

      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
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
        flake = "~/omnidreams"; # sets NH_OS_FLAKE variable for you
      };

      programs.git = {
        enable = true;
        settings = {
          user.name = "UpFourAGoodTime";
          user.email = "GabrielEaker@pm.me";
          init.defaultBranch = "main";
          safe.directory = "/etc/nixos/";
        };
      };

      home.sessionVariables = {
        EDITOR = "nano";
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;

      nix.settings.download-buffer-size = 524288000;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
