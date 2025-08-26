# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a nix-darwin and home-manager based dotfiles repository that manages macOS system configuration and user environment. The repository uses Nix flakes for reproducible builds and Home Manager for user-specific configurations.

Key architectural components:
- **Flake-based configuration**: `flake.nix` defines inputs (nixpkgs, nix-darwin, home-manager) and outputs for different machines
- **Machine-specific configs**: Each machine has its own directory in `machines/` with `configuration.nix` (system-level) and `home.nix` (user-level) files
- **Shared components**: Common configurations are in `common/` for reusability across machines
- **Out-of-store symlinks**: Dotfiles are symlinked from the repository to allow easy editing without rebuilding

## Common Development Commands

### System Management
```bash
# Initial setup (first time only)
nix run nix-darwin -- switch --flake .

# Update flake inputs and rebuild system
nix flake update && darwin-rebuild switch --flake .

# Rebuild system without updating inputs
darwin-rebuild switch --flake .

# Check system configuration
darwin-rebuild check --flake .
```

### Formatting
```bash
# Format all Nix files
nixfmt **/*.nix
```

## Machine Configuration Structure

Currently supports two machines:
- `joiedevirve`: Minimal configuration
- `chatjoyeux`: Full development setup with homebrew packages

### Adding a New Machine
1. Create directory in `machines/<machine-name>/`
2. Add `configuration.nix` (system config) and `home.nix` (user config)
3. Add machine to `flake.nix` outputs: `darwinConfigurations.<machine-name> = mkSystem "<machine-name>";`

## Dotfiles Organization

Dotfiles are organized in `dotfiles/` by application:
- `fish/`: Fish shell configuration with themes and aliases
- `lazyvim/`: Neovim configuration using LazyVim framework
- `wezterm/`: Terminal configuration with Lua themes
- `starship/`: Shell prompt configuration
- `aerospace/`: Window manager configuration
- `neovide/`: GUI Neovim configuration

All dotfiles are symlinked using `mkOutOfStoreSymlink` to maintain editability.

## Key System Features

- **TouchID for sudo**: Enabled on all machines
- **Homebrew integration**: Managed declaratively through nix-darwin
- **Shell setup**: Fish as primary shell with zsh/bash available
- **Nerd Fonts**: JetBrains Mono and Fira Code installed via Nix
- **Development tools**: Includes claude-code, lazygit, k9s, terraform, AWS CLI, Docker, etc.

## LazyVim Configuration

The Neovim setup uses LazyVim with custom configurations:
- Disabled line numbers and relative numbers
- FZF as picker instead of telescope
- Copilot and Terraform support enabled
- Custom keybindings for Neovide GUI
- Rose Pine themes configured

## Important Notes

- Uses `mkOutOfStoreSymlink` for dotfiles to allow editing without rebuilds
- Git configuration includes delta for better diffs and GPG signing
- System uses determinate nix installer (nix.enable = false)
- Home Manager backup extension is "before-home-manager"
- All configurations follow the rose-pine color scheme theme