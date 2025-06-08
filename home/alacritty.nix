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
			padding = { x = 4; y = 0; };
			decorations = "Buttonless";
			opacity = 1;
			startup_mode = "Windowed";
			title = "Alacritty";
			dynamic_title = true;
			decorations_theme_variant = "None";
		};

		font = let jetbrainsMono = style: {
			family = "IosevkaTerm Nerd Font Mono";
			inherit style;
		}; in {
			size = 16;
			normal = jetbrainsMono "Light";
		};

		cursor = {
			style = "Block";
		};

		general.live_config_reload = true;
	};
}
