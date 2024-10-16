{
  description = "derui's dotfiles";

  inputs = {
  };

  outputs = { self }:
    let
      dotfile-install =  {home, xdg, ...}: {
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
      };
    in {

    nixosModules.default = dotfile-install;
    
  };
}
