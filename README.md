# Yet another dotfiles

These are my dotfiles that I use as a reference point for my local setup; I
used to have linux machine some years ago, so it was
also convenient to share vim and some other tools setup this way, but nowadays I
use macs both for my home and work, so this is
probably not very useful outside of Apple ecosystem anymore, sorry.

These are bootstrapped with [`nix-darwin`](https://github.com/nix-darwin/nix-darwin),
so to get going you'd need to

- get `nix` with flakes (I used [Determinate shell-based installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#usage)):

```sh
curl --proto '=https' --tlsv1.2 -sSf -L \
https://install.determinate.systems/nix | sh -s -- install
```

- link dotfiles folder to `/etc/nix-darwin`, since
  we're managing the whole system with it.

- copy / create your own version of `machines` that matches your hostname.

- run it first time to install `nix-darwin` and `home-manager`:

```sh
sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch
```

- ...and that's it!

To update the whole system:

```sh
nix flake update && sudo darwin-rebuild switch
```
