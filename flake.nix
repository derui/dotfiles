{
  description = "derui's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      dotfile-install =
        { home, xdg, ... }:
        {
          xdg.configFile = {
            "alacritty".source = ./config/alacritty;
            "fish/config.fish".source = ./config/fish/config.fish;
            "fish/conf.d".source = ./config/fish/conf.d;
            "fish/functions".source = ./config/fish/functions;
            "hypr".source = ./config/hypr;
            "mako".source = ./config/mako;
            "nvim".source = ./config/nvim;
            "sway".source = ./config/sway;
            "tmux".source = ./config/tmux;
            "waybar".source = ./config/waybar;
            "kitty".source = ./config/kitty;
            "git".source = ./config/git;
            "direnv".source = ./config/direnv;
            "xkb".source = ./config/xkb;
            "starship.toml".source = ./config/starship.toml;
          };

          home.file = {
            ".ideavimrc".source = ./ideavimrc;
            ".npmrc".source = ./npmrc;
            ".bash_profile".source = ./bash_profile;
            ".profile".source = ./profile;
          };
        };
    in
    {

      nixosModules.default = dotfile-install;
      formatter.x86_64-linux = (import nixpkgs { system = "x86_64-linux"; }).nixfmt-rfc-style;

      devShells.x86_64-linux =  (
        let
          pkgs = (import nixpkgs { system = "x86_64-linux"; });
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              deno
            ];
          };
        }
      );

    };
}
