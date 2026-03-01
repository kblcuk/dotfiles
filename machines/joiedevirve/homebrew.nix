{ ... }:
{
  # Additional homebrew packages specific to joiedevirve
  homebrew = {
    brews = [
      # Can be installed via nix as well, but
      # it always tries to build it from source
      "ffmpeg"
    ];
    casks = [
      "heroic"
      "imageoptim"
      "keycastr"
      "neovide-app"
      "obsidian"
      "steam"
      "vlc"
      "zed"
      "zoom"
    ];
  };
}
