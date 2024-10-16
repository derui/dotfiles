{
  description = "derui's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = ["x86_64-linux" "aarch64-darwin"];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      dotfile-install = forAllSystems (system:
        let pkgs = import nixpkgs {inherit system;}; in
        {home, xdg, ...}: {
          xdg.configFile = {
            "alacritty".source = ./config/aalacritty;
            "fish".source = ./config/fish;
            "hyrp".source = ./config/hypr;
            "mako".source = ./config/mako;
            "nvim".source = ./config/nvim;
            "sway".source = ./config/sway;
            "tmux".source = ./config/tmux;
            "waybar".source = ./config/waybar;
            "git".source = ./config/git;
            "starship.toml".source = ./config/starship.toml;
          };

          home.file = {
            ".ideavimrc".source = ./ideavimrc;
            ".npmrc".source = ./npmrc;
          };
        }
      );
    in {

    packages.x86_64-linux.default = dotfile-install.x86_64-linux;
    packages.aarch64-darwin.default = dotfile-install.aarch64-darwin;

  };
}
