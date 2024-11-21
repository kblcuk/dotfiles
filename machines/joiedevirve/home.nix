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
      home.file = {
        ".config/fish/themes" = {
          source = "${rose-pine-fish}/themes";
          recursive = true;
        };
        ".config/wezterm/lua" = {
          source = ../../dotfiles/wezterm/lua;
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

      home.packages = with inputs.nixpkgs.legacyPackages.${pkgs.system}; [
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        aria2
        bitwarden
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
      ];

      programs.wezterm = {
        enable = true;
        package = inputs.wezterm.packages.${pkgs.system}.default;
        extraConfig = builtins.readFile ../../dotfiles/wezterm/wezterm.lua;
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
        # FIXME: This is needed to address bug where the $PATH is re-ordered by
        # the `path_helper` tool, prioritising Apple’s tools over the ones we’ve
        # installed with nix.
        #
        # This gist explains the issue in more detail: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
        # There is also an issue open for nix-darwin: https://github.com/LnL7/nix-darwin/issues/122
        loginShellInit =
          let
            # We should probably use `config.environment.profiles`, as described in
            # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1659465635
            # but this takes into account the new XDG paths used when the nix
            # configuration has `use-xdg-base-directories` enabled. See:
            # https://github.com/LnL7/nix-darwin/issues/947 for more information.
            profiles = [
              "/etc/profiles/per-user/$USER" # Home manager packages
              "$HOME/.nix-profile"
              "(set -q XDG_STATE_HOME; and echo $XDG_STATE_HOME; or echo $HOME/.local/state)/nix/profile"
              "/run/current-system/sw"
              "/nix/var/nix/profiles/default"
            ];

            makeBinSearchPath = pkgs.lib.concatMapStringsSep " " (path: "${path}/bin");
          in
          ''
            # Fix path that was re-ordered by Apple's path_helper
            fish_add_path --move --prepend --path ${makeBinSearchPath profiles}
            set fish_user_paths $fish_user_paths
          '';
      };

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
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
