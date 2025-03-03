{
  inputs,
  pkgs,
  mac-app-util,
  neovim-nightly-overlay,
  ...
}:

let
  rose-pine-fish = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "38aab5baabefea1bc7e560ba3fbdb53cb91a6186";
    hash = "sha256-bSGGksL/jBNqVV0cHZ8eJ03/8j3HfD9HXpDa8G/Cmi8=";
  };
in
{
  # Auto-link .app to correct location,
  # so spotlight finds them
  home-manager.sharedModules = [
    mac-app-util.homeManagerModules.default
  ];

  users.users.alex = {
    name = "alex";
    home = "/Users/alex";
    shell = pkgs.fish;
  };
  home-manager.users.alex =
    { pkgs, ... }:
    {
      home.file = {
        ".config/fish/themes" = {
          source = "${rose-pine-fish}/themes";
          recursive = true;
        };
        # wezterm
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
      };

      home.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        cachix
        gnupg
        bat
        httpie
        neovim
        neovide
        ripgrep
        coreutils
        fd
        eza
        delta
        lazygit
        glow
        pinentry_mac
        pinentry-curses
        github-cli
        speedtest-cli
        kubernetes-helm
        kubectl
        sops
        age
      ];

      programs.wezterm = {
        enable = true;
        package = inputs.wezterm.packages.${pkgs.system}.default;
        extraConfig = builtins.readFile ../../dotfiles/wezterm/wezterm.lua;
      };

      programs.neovim = {
        enable = true;
        # package = nixpkgs.legacyPackages.${pkgs.system}.neovim-unwrapped;
        package = neovim-nightly-overlay.packages.${pkgs.system}.default;
      };

      programs.bat = {
        enable = true;
        extraPackages = [ pkgs.bat-extras.batman ];
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
      programs.fzf.enable = true;
      programs.fzf.enableFishIntegration = false;
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
      programs.starship.enable = true;

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
      programs.git = {
        enable = true;
        userName = "Alexei Mikhailov";
        userEmail = "alexei.mikhailov@socialfirstgames.com";
        signing = {
          key = "A3CFF99E76AC8F54";
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
