{ pkgs, ... }:
{
  enable = true;
  aggressiveResize = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  shell = "${pkgs.zsh}/bin/zsh";
  shortcut = "a";
  sensibleOnTop = false;

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
  '';
}

