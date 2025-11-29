# Dotfiles #
This repository is dotfiles managed by derui.

Dotfiles managed in this repository are there. This repository aims to support macOS and NixOS

- Wayland
  - Use [sway](https://github.com/swaywm/sway)
  - Use [Hyprland](https://hyprland.org/)
- Shells
  - bash
  - fish
- terminals
  - alacritty
  - kitty
- CLI tools
  - git
  - tmux
  - starship
- GUI tools
  - mako
  - waybar
  

# Install #

First, you clone this repository to anywhere, and then, choice method to install for your environment.

## NixOS/Nix ##
If you use NixOS, you can install this repository as flake.


2. ``cd dotfiles``
3. ``./bootstrap.sh``
4. run ``fisher`` in new fish shell.
5. if you want to use some languages/tools, you can use `asdf` command in your shell.

> NOTICE: I do not recommend to use fish as login shell. Please keep bash as your login shell.
