# Yet another dotfiles

These are my dotfiles that I use as a reference point for my local setup; I used to have linux machine some years ago, so it was
also convenient to share vim and some other tools setup this way, but nowadays I use macs both for my home and work, so this is
probably not very useful outside of Apple ecosystem anymore, sorry.

These are bootstrapped with `nix-darwin`, so to get going you'd need to

- get nix with flakes (I used [Determinate shell-based installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#usage)):

```curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

```

- run it first time to install `nix-darwin` and `home-manager`:

```
nix run nix-darwin -- switch --flake .
```

- ...and that's it!

To update the whole system:

```nix flake update && darwin-rebuild switch --flake .

```
