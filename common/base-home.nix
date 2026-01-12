{
  pkgs,
  nixpkgs,
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

  users.users.alex = {
    name = "alex";
    home = "/Users/alex";
    shell = pkgs.fish;
  };

  home-manager.users.alex =
    { config, pkgs, ... }:
    {

      xdg.enable = true;

      # Base packages that all machines should have
      home.packages = import ./packages.nix { inherit pkgs nixpkgs; };

      # Could be xdg.configDir, but then we can't link
      # our dot files since they become out of store, and
      # building complains about it. But I don't care about
      # having reproducible dotfiles, I want them to be easily
      # tweakable (and we still can commit them to git once
      # they are done)
      home.file = with config.lib.file; {
        ".config/fish/themes" = {
          source = "${rose-pine-fish}/themes";
          recursive = true;
        };
        ".config/fish/conf.d" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/dotfiles/dotfiles/fish/conf.d";
          recursive = true;
        };
        ".config/wezterm" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/dotfiles/dotfiles/wezterm";
          recursive = true;
        };
        ".config/nushell/config.nu" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/dotfiles/dotfiles/nushell/config.nu";
        };
        ".config/lazyvim" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/dotfiles/dotfiles/lazyvim";
          recursive = true;
        };
        ".config/neovide" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/dotfiles/dotfiles/neovide";
          recursive = true;
        };
        ".config/starship.toml" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/dotfiles/dotfiles/starship/starship.toml";
        };
        ".config/aerospace" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/dotfiles/dotfiles/aerospace";
          recursive = true;
        };
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
      programs.fzf.enableFishIntegration = true;
      programs.zsh.enable = true;

      programs.fish = {
        enable = true;
      };

      programs.home-manager.enable = true;

      programs.gpg = {
        enable = true;
      };

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.05";
    };

  home-manager.backupFileExtension = "before-home-manager";
}
