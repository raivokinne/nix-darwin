{ config, pkgs, ... }:
{
  enable = true;
  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";
  shellAliases = {
    vim = "nvim";
    ls = "ls --color";
	rebuild = "sudo darwin-rebuild switch --flake ~/.config/nix#raivokinne && exec zsh";
  };
  initContent = ''
		bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"
    bindkey -e
	export PATH="$PATH:$HOME/.config/composer/vendor/bin"
	export PATH="$PATH:$HOME/.cargo/bin"
	export PATH="$PATH:$HOME/.local/bin"
	export PATH="$PATH:$HOME/.config/emacs/bin"
	export EDITOR=nvim
	export VISUAL=nvim
	alias l='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
	alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
	alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
	alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h'
  alias em="emacs -nw"
  '';
}
