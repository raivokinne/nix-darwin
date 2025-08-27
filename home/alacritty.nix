{ config, pkgs, pkgsUnstable, ... }:
{
	enable = true;
	package = pkgsUnstable.alacritty;

	settings = {
		colors = {
			primary = {
				background = "#000000";
				foreground = "#ffffff";
			};
		};
		window = {
			padding = { x = 0; y = 0; };
			opacity = 1;
			startup_mode = "Windowed";
			title = "Alacritty";
			dynamic_title = true;
			decorations = "Full";
		};

		general = {
			live_config_reload = true;
		};

		font = let jetbrainsMono = style: {
			family = "FiraCode Nerd Font";
			inherit style;
		}; in {
			size = 16;
			normal = jetbrainsMono "Regular";
			bold = jetbrainsMono "Bold";
			italic = jetbrainsMono "Italic";
		};

		cursor = {
			style = "Block";
		};

		env = {
			TERM = "xterm-256color";
		};
	};
}

