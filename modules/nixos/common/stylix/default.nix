{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  #img = builtins.fetchurl "https://raw.githubusercontent.com/ari-rs/wallpapers/refs/heads/master/${config.cfg.stylix.image}.png";
  # TODO: Make much better wallpaper system...
  img = pkgs.fetchurl {
    url ="https://raw.githubusercontent.com/ari-rs/wallpapers/refs/heads/master/${config.cfg.stylix.image}.png";
    sha256 = "0c90c4f15b5w4hx9sx51qa9nz433xjaqi9wscdxs1xvz30vglswv";
  };
in
{
  options.cfg.stylix.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs stylix";
  };
  options.cfg.stylix.scheme = lib.mkOption {
    type = lib.types.str;
    default = "catppuccin-mocha";
    description = "chooses which color scheme to use";
  };
  options.cfg.stylix.image = lib.mkOption {
    type = lib.types.str;
    default = "austria_landscape";
    description = "name of of the wallpaper";
  };

  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  config = lib.mkIf config.cfg.stylix.enable {
    fonts.packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-emoji
      pkgs.noto-fonts-cjk-sans
      pkgs.corefonts
    ];
    stylix = {
      enable = true;
      cursor.size = 20;
      image = img;
      cursor.name = "Bibata-Modern-Ice"; # TODO: resolve mkForce in hyprcursor module...
      cursor.package = pkgs.bibata-cursors;
      polarity = "dark"; # Probably not required
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.cfg.stylix.scheme}.yaml";
      fonts = {
        serif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.ny;
          name = "New York Medium";
        };
        sansSerif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
          name = "SF Pro Text";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
      };
    };
  };
}
