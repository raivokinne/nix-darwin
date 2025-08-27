{ config, pkgs, pkgsUnstable, ... }:
{
  enable = true;
  package = pkgsUnstable.alacritty;

  settings = {
    window = {
      padding = { x = 0; y = 0; };
      opacity = 1;
      startup_mode = "Windowed";
      title = "Alacritty";
      dynamic_title = true;
	  decorations = "Full";
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

