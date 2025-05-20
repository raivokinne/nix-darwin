{pkgs, config, ...}:
let
	inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
  };

  xdg.configFile.nvim.source = mkOutOfStoreSymlink /Users/raivokinne/nix/home/neovim/config;
}
