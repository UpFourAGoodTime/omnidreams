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

      users.users."gabriele" = {
        createHome = true;
        description = "Gabriel Eaker";
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
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
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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

      home.packages = [
        pkgs.ungoogled-chromium
        pkgs.freetube
        pkgs-stable.zed-editor

        pkgs.blueman
        pkgs.localsend

        pkgs.logseq
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

      home.sessionVariables = {
        # QT_QPA_PLATFORMTHEME = "gtk3";
        # QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
      };

      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
      home.file = {
        "user-config.kdl".text = ''

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
