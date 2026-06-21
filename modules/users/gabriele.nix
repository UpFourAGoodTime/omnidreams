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

      # Create a customized version of logseq
      logseq-patch = pkgs.logseq.override {
        electron_39 = pkgs.electron_40;
      };

      ungoogled-chromium-custom = (
        pkgs.ungoogled-chromium.override {
          commandLineArgs = [
            "--enable-features=AcceleratedVideoEncoder"
            "--enable-features=AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
            "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
            "--enable-features=UseMultiPlaneFormatForHardwareVideo"
            "--ignore-gpu-blocklist"
            "--enable-zero-copy"
            "--ozone-platform=wayland"
            "--enable-unsafe-swiftshader"
            "--flag-switches-begin"
            "--enable-experimental-web-platform-features"
            "--enable-unsafe-swiftshader"
            "--extension-mime-request-handling=always-prompt-for-install"
            "--enable-features=HdrAgtm,WaylandSessionManagement"
            "--flag-switches-end"
          ];
        }
      );

    in
    {
      imports = [
        inputs.omniri.homeModules.default

        inputs.chromium-webapps.homeManagerModules.default
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

      programs.chromium-webapps = {
        enable = true;
        webApps = [
          {
            name = "Mail";
            url = "https://mail.proton.me";
            icon = ../../assets/icons/webapps/Proton/mail.png;
            appDataDir = false;
          }
          {
            name = "FMD Server";
            url = "https://server.fmd-foss.org/";
            icon = ../../assets/icons/webapps/Proton/FMD.png;
            appDataDir = false;
          }
          {
            name = "Fluffychat";
            url = "https://fluffychat.im/web";
            icon = ../../assets/icons/webapps/Proton/fluffychat.png;
            appDataDir = false;
          }
        ];

        package = ungoogled-chromium-custom;
      };

      programs.chromium = {
        enable = true;
        package = ungoogled-chromium-custom;

      };

      services.syncthing = {
        enable = true;

        settings = {
          gui = {
            user = "admin";
            password = "%qz&w!fcRsPqwGDD0BkAuDDrcVEsQ!7k^mSe$d0eHbyGyrEEz@4tDRGqp5Vg*&Ed"; # This is insecure, consider this password compromised when setting up Sops-Nix
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
        pkgs.freetube
        pkgs.zed-editor
        pkgs.element-desktop

        pkgs.localsend

        logseq-patch
        pkgs.anki

        pkgs.obs-studio
        pkgs.vlc

        pkgs.prismlauncher

        pkgs.nh
        pkgs.nixd
        pkgs.nil

        pkgs.nerd-fonts.jetbrains-mono
        pkgs.nerd-fonts.hasklug
        pkgs.nerd-fonts.hurmit

        # pkgs.python312Packages.yt-dlp

      ];

      xdg.mimeApps.defaultApplications = {
        "text/html" = "chromium-desktop.desktop";
        "x-scheme-handler/http" = "chromium-desktop.desktop";
        "x-scheme-handler/https" = "chromium-desktop.desktop";
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
        flake = "~/omnidreams"; # sets NH_OS_FLAKE variable for you
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
