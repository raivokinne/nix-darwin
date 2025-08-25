{pkgs, config, ...}:
let
	inherit (config.lib.file) mkOutOfStoreSymlink;
in
	{
	programs.neovim = {
		enable = true;
		package = pkgs.neovim-unwrapped;
		defaultEditor = true;
		plugins = [
			{
				plugin = pkgs.vimPlugins.sqlite-lua;
			}
		];
	};

	xdg.configFile.nvim.source = mkOutOfStoreSymlink /Users/raivokinne/.config/nix/home/neovim/config;
}
