{ config, pkgs, pkgsUnstable, ... }:
let
	inherit (config.lib.file) mkOutOfStoreSymlink;
in
	{
	imports = [
		./services/aerospace.nix
		./home/neovim/neovim.nix
	];

	programs.home-manager.enable = true;

	home.username = "raivokinne";
	home.homeDirectory = "/Users/raivokinne";

	home.packages = with pkgs; [
		awscli
		ffmpeg
		ripgrep
		rustup
		obsidian
		tailwindcss
		tailwindcss-language-server
		pass
		lua-language-server
		stylua
		zoxide
		iperf
		air
		templ
		fastfetch
		eza
		alacritty
		starship
		git
		fd
		jq
		lazydocker
		nh
		openconnect
		pipenv
		python3
		ripgrep
		btop
		nodejs
		go
		php
		zip
		openssl
		micromamba # faster conda
		pkg-config # compiling flags generator (for libraries)
		luarocks              # lua package manager
		pnpm # faster npm
		lua5_4 # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/interpreters/lua-5/default.nix
		gfortran14
		typescript
		prettierd
		go
		rustc
		android-tools
		zig
		quarto
		typst
		deno
		plantuml
		autoconf
		discord
	];

	programs = {
		tmux = (import ./home/tmux.nix { inherit pkgs; });
		zsh = (import ./home/zsh.nix { inherit config pkgs; });
		starship = (import ./home/starship.nix { inherit pkgs; });
		zoxide = (import ./home/zoxide.nix { inherit pkgs; });
		fzf = (import ./home/fzf.nix { inherit pkgs; });
		btop = (import ./home/btop.nix { inherit pkgs; });
		fastfetch = (import ./home/fastfetch.nix { inherit pkgs; });
		alacritty = (import ./home/alacritty.nix { inherit config pkgs pkgsUnstable; } );
	};

	home.stateVersion = "25.05";
}
