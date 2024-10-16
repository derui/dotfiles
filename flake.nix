{
  description = "derui's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
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

    # For testing setup. YOU DON'T USE THIS ANYWAY.
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
     modules = [
       ({pkgs, ...}: {
         boot.isContainer = true;

         # version of this flake to show nixos-version
         system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

         # Network configuration.
         networking.useDHCP = false;
         networking.firewall.allowedTCPPorts = [ ];
         
         # make a test user.
         users.users = {
           alice = {
             isNormalUser = true;
             extraGroups = ["wheel"];
             password = "test";
           };
         };
       })
     ];
    };
    
  };
}
