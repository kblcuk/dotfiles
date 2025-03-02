{
  inputs,
  pkgs,
  mac-app-util,
  ...
}:

let
  rose-pine-fish = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "38aab5baabefea1bc7e560ba3fbdb53cb91a6186";
    hash = "sha256-bSGGksL/jBNqVV0cHZ8eJ03/8j3HfD9HXpDa8G/Cmi8=";
  };
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  # Auto-link .app to correct location,
  # so spotlight finds them
  home-manager.sharedModules = [ mac-app-util.homeManagerModules.default ];

  users.users.alex = {
    name = "alex";
    home = "/Users/alex";
    shell = pkgs.fish;
  };
  home-manager.users.alex =
    { pkgs, ... }:
    {
      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;

      home.file = {
        ".config/fish/themes" = {
          source = "${rose-pine-fish}/themes";
          recursive = true;
        };
        ".config/wezterm" = {
          source = ../../dotfiles/wezterm;
          recursive = true;
        };
        ".config/fish" = {
          source = ../../dotfiles/fish;
          recursive = true;
        };
        ".config/lazyvim" = {
          source = ../../dotfiles/lazyvim;
          recursive = true;
        };
        ".config/amethyst" = {
          source = ../../dotfiles/amethyst;
          recursive = true;
        };
        ".config/aerospace" = {
          source = ../../dotfiles/aerospace;
          recursive = true;
        };
      };

      home.packages =
        with pkgs;
        [
          aria2
          coreutils
          diffutils
          eza
          fd
          ffmpeg
          github-cli
          glow
          gnupg
          httpie
          lazygit
          neovim
          pinentry-curses
          pinentry_mac
          ripgrep
          speedtest-cli
          starship
          wget
        ]
        ++ (with inputs.nixpkgs.legacyPackages.${pkgs.system}; [ nerd-fonts.jetbrains-mono ]);

      imports = [
        inputs.spicetify-nix.homeManagerModules.default
      ];

      programs.spicetify = {
        enable = true;
        theme = spicePkgs.themes.ziro;
        colorScheme = "rose-pine-moon";

        enabledExtensions = with spicePkgs.extensions; [
          hidePodcasts
        ];
      };

      programs.bat = {
        enable = true;
        config = {
          theme = "rose-pine-dawn";
        };
        themes = {
          rose-pine-dawn = {
            src = pkgs.fetchFromGitHub {
              owner = "rose-pine";
              repo = "tm-theme"; # Bat uses sublime syntax for its themes
              rev = "c4235f9a65fd180ac0f5e4396e3a86e21a0884ec";
              sha256 = null;
            };
            file = "dist/themes/rose-pine-dawn.tmTheme";
          };
          rose-pine-moon = {
            src = pkgs.fetchFromGitHub {
              owner = "rose-pine";
              repo = "tm-theme"; # Bat uses sublime syntax for its themes
              rev = "c4235f9a65fd180ac0f5e4396e3a86e21a0884ec";
              sha256 = null;
            };
            file = "dist/themes/rose-pine-moon.tmTheme";
          };
        };
      };

      programs.zoxide.enable = true;
      programs.zsh.enable = true;

      programs.fish = {
        enable = true;
        functions = {
          fish_greeting = "";
        };
        interactiveShellInit = ''
          fish_vi_key_bindings
        '';
      };

      programs.git = {
        enable = true;
        userName = "Alexei Mikhailov";
        userEmail = "kblcuk@pm.me";
        signing = {
          key = "A983E913138CD12E";
          signByDefault = true;
        };
        delta = {
          enable = true;
          options = {
            navigate = true;
          };
        };
        extraConfig = {
          merge = {
            conflictstyle = "diff3";
          };
          pull = {
            rebase = true;
          };
          diff = {
            colorMoved = "default";
          };
        };
      };

    };

  home-manager.backupFileExtension = "before-home-manager";
}
