{ config, pkgs, pkgsUnstable, ... }:
{
  enable = true;
  package = pkgsUnstable.alacritty;

  settings = {
    window = {
      padding = { x = 4; y = 8; };
      decorations = "full";
      opacity = 1;
      startup_mode = "Windowed";
      title = "Alacritty";
      dynamic_title = true;
      decorations_theme_variant = "None";
    };

    general = {
      import = [ pkgs.alacritty-theme.tokyo_night ];
	  live_config_reload = true;
    };

    font = let jetbrainsMono = style: {
      family = "JetBrainsMono Nerd Font";
      inherit style;
    }; in {
      size = 16;
      normal = jetbrainsMono "Regular";
      bold = jetbrainsMono "Bold";
      italic = jetbrainsMono "Italic";
      bold_italic = jetbrainsMono "Bold Italic";
    };

    cursor = {
      style = "Block";
    };

    env = {
      TERM = "xterm-256color";
    };
  };
}

