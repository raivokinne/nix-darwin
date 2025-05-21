{ pkgs, ... }:
{
  enable = true;
  aggressiveResize = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  newSession = true;
  secureSocket = true;
  shell = "${pkgs.zsh}/bin/zsh";
  shortcut = "a";
  terminal = "screen-256color";
  sensibleOnTop = false;

  plugins = with pkgs.tmuxPlugins; [
    yank
    vim-tmux-navigator
  ];

  extraConfig = ''
    set -gu default-command
    set-option -sa terminal-overrides ",xterm*:Tc"

    set -g prefix C-a
    set -g mouse on

    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    bind-key v split-window -h -c "#{pane_current_path}"
    bind-key h split-window -v -c "#{pane_current_path}"

    bind -n C-p previous-window
    bind -n C-n next-window

    bind -n C-S-k resize-pane -U 5
    bind -n C-S-j resize-pane -D 5
    bind -n C-S-h resize-pane -L 5
    bind -n C-S-l resize-pane -R 5

    bind-key y set-window-option synchronize-panes\; display-message "synchronize mode toggled."

    bind c new-window -c "#{pane_current_path}"

    set -g base-index 1
    set -g pane-base-index 1
    set-window-option -g pane-base-index 1
    set-option -g renumber-windows on

    bind -n C-S-[ swap-window -t -1
    bind -n C-S-] swap-window -t +1

    set -g status-position bottom
    set -g status-justify left
    set -g status-style "bg=colour0 fg=colour15"
    set -g status-left ""
    set -g status-right "#[fg=colour15,bg=colour0] %d/%m #[fg=colour0,bg=colour15] %H:%M:%S "
    set -g status-right-length 50
    set -g status-left-length 20

    setw -g window-status-current-style "fg=colour0 bg=colour15 bold"
    setw -g window-status-current-format " #I#[fg=colour0]:#[fg=colour0]#W#[fg=colour0]#F "

    setw -g window-status-style "fg=colour15 bg=colour0"
    setw -g window-status-format " #I#[fg=colour0]:#[fg=colour15]#W#[fg=colour0]#F "

    setw -g window-status-bell-style "fg=colour0 bg=colour15 bold"

    bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
    set -g window-status-separator ""
  '';
}

