{ pkgs, ... }:
let
	tokyo-night = pkgs.tmuxPlugins.mkTmuxPlugin {
		pluginName = "tokyo-night";
		version = "unstable-2023-01-06";
		src = pkgs.fetchFromGitHub {
			owner = "janoamaral";
			repo = "tokyo-night-tmux";
			rev = "master";
			sha256 = "sha256-3rMYYzzSS2jaAMLjcQoKreE0oo4VWF9dZgDtABCUOtY=";
		};
	};

in
	{
	enable = true;
	aggressiveResize = true;
	baseIndex = 1;
	keyMode = "vi";
	shortcut = "a";
	terminal = "screen-256color";
	plugins = with pkgs.tmuxPlugins; [
		rose-pine
		tokyo-night
		yank
		vim-tmux-navigator
	];
	extraConfig = ''
		set-option -sa terminal-overrides ",xterm*:Tc"
set -g prefix C-a
bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind -n C-p previous-window
bind -n C-n next-window
set -g base-index 1
bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
set -g status-style 'bg=#1a1b26 fg=#a9b1d6'
set -g @tokyo-night-tmux_window_id_style hsquare
	set -g @tokyo-night-tmux_show_datetime 0

	run-shell ${tokyo-night}/share/tmux-plugins/tokyo-night/tokyo-night.tmux
	'';
}

