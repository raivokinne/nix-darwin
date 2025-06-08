{ config, pkgs, ... }:
{
  enable = true;
  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";
  shellAliases = {
    vim = "nvim";
    ls = "ls --color";
	rebuild = "sudo darwin-rebuild switch --flake .#raivokinne && exec zsh";
  };
  initContent = ''
    bindkey -e

	ZSH_THEME=robbyrussell

    # disable sort when completing `git checkout`
    zstyle ':completion:*:git-checkout:*' sort false
    # set descriptions format to enable group support
    # NOTE: don't use escape sequences here, fzf-tab will ignore them
    zstyle ':completion:*:descriptions' format '[%d]'
    # set list-colors to enable filename colorizing
    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    zstyle ':completion:*' menu no
    # preview directory's content with eza when completing cd
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'
    # switch group using `<` and `>`
    zstyle ':fzf-tab:*' switch-group '<' '>'
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
  oh-my-zsh = {
    enable = false;
    plugins = [
       "git" "sudo" "golang" "kubectl" "kubectx" "rust" "command-not-found" "pass"
    ];
  };
  plugins = [
    {
      name = "zsh-autosuggestions";
      src = pkgs.zsh-autosuggestions;
      file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
    }
    {
      name = "zsh-completions";
      src = pkgs.zsh-completions;
      file = "share/zsh-completions/zsh-completions.zsh";
    }
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.zsh-syntax-highlighting;
      file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
    }
    {
      name = "fzf-tab";
      src = pkgs.zsh-fzf-tab;
      file = "share/fzf-tab/fzf-tab.plugin.zsh";
    }
  ];
}
