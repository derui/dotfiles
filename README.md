# Dotfiles #
This repository is dotfiles of derui.

Dotfiles managed in this repository are there.

- X11 settings
- Wayland settings
  - Use [sway](https://github.com/swaywm/sway)
- bash settings
- fish settings
  - fisher integrated
- mlterm settings
- alacritty settings
- tmux settings
- anyenv integration
- starship integration
- some useful shell scripts (for personal use)

## Requirement ##
- Fish (least 3.0.0)
- tmux (least 3.0)

## Other requirement ##
- If you want to use Wayland
  - i3status
  - sway
- If you want to use X11
  - i3-gaps
  - i3blocks

## Install ##

1. clone this repository to $HOME
2. ``cd dotfiles``
3. ``./bootstrap.sh``
4. run ``fisher`` in new fish shell.
5. if you want to use *env, you can use `anyenv` command in your shell.

> NOTICE: I do not recommend to use fish as login shell. Please keep bash as your login shell.
