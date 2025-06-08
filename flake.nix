{
	description = "Example Darwin system flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
		nix-darwin.url = "github:LnL7/nix-darwin";
		nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		templ.url = "github:a-h/templ";
		home-manager.url = "github:nix-community/home-manager/release-25.05";
		nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
		home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
		flake-utils.url    = "github:numtide/flake-utils";
		spacebar = {
			url = "github:shaunsingh/spacebar";
		};
	};

	outputs = { self, nix-darwin, nixpkgs, nixpkgs-unstable, nix-homebrew, templ, home-manager,spacebar, ... }@inputs:
		let
			configuration = { pkgs, config, ... }: {
				# List packages installed in system profile. To search by name, run:
				# $ nix-env -qaP | grep wget
				nixpkgs.config.allowUnfree = true;
				nixpkgs.overlays = [
					inputs.templ.overlays.default
					spacebar.overlay
				];
				environment.systemPackages = with pkgs; [
					neovim
				];

				users.users.raivokinne = {
					name = "raivokinne";
					home = "/Users/raivokinne";
				};

				system.primaryUser = "raivokinne";

				services = {
					sketchybar = {
						enable = true;
					};
					jankyborders = {
						enable = false;                     # turn the service on
					};
				};

				homebrew = {
					enable = true;
					casks = [ "podman-desktop" "docker" "font-iosevka" "ghostty" ];
					brews = [ "podman" "mariadb" "podman-compose" "composer" ];
					onActivation = {
						autoUpdate = true;
						cleanup = "uninstall";
						upgrade = true;
					};
				};

				# nix.package = pkgs.nix;

				# Necessary for using flakes on this system.
				nix.settings.experimental-features = "nix-command flakes";

				# Create /etc/zshrc that loads the nix-darwin environment.
				programs.zsh.enable = true;  # default shell on catalina

				# Set Git commit hash for darwin-version.
				system.configurationRevision = self.rev or self.dirtyRev or null;

				security.pam.services.sudo_local.touchIdAuth = true;

				system = {
					defaults = {
						CustomUserPreferences = {
							NSGlobalDomain."com.apple.mouse.linear" = true;
						};
						NSGlobalDomain = {
							AppleICUForce24HourTime = true;
							AppleInterfaceStyle = "Dark";
							ApplePressAndHoldEnabled = false;
							AppleShowAllExtensions = true;
							KeyRepeat = 2;
							NSAutomaticCapitalizationEnabled = false;
							NSAutomaticDashSubstitutionEnabled = false;
							NSAutomaticQuoteSubstitutionEnabled = false;
							NSAutomaticSpellingCorrectionEnabled = false;
							NSAutomaticWindowAnimationsEnabled = false;
							NSDocumentSaveNewDocumentsToCloud = false;
							NSNavPanelExpandedStateForSaveMode = true;
							PMPrintingExpandedStateForPrint = true;
						};
						LaunchServices = {
							LSQuarantine = false;
						};
						trackpad = {
							TrackpadRightClick = true;
							TrackpadThreeFingerDrag = true;
							Clicking = true;
						};
						finder = {
							AppleShowAllFiles = true;
							CreateDesktop = false;
							FXDefaultSearchScope = "SCcf";
							FXEnableExtensionChangeWarning = false;
							FXPreferredViewStyle = "Nlsv";
							QuitMenuItem = true;
							ShowPathbar = true;
							ShowStatusBar = true;
							_FXShowPosixPathInTitle = true;
							_FXSortFoldersFirst = true;
						};
						dock = {
							autohide = true;
							expose-animation-duration = 0.15;
							show-recents = false;
							showhidden = true;
							persistent-apps = [];
							tilesize = 30;
							wvous-bl-corner = 1;
							wvous-br-corner = 1;
							wvous-tl-corner = 1;
							wvous-tr-corner = 1;
						};
						screencapture = {
							location = "/Users/raivokinne/Screenshot/";
							type = "png";
							disable-shadow = true;
						};
					};
					keyboard = {
						enableKeyMapping = true;
						userKeyMapping = [
							{
								HIDKeyboardModifierMappingDst = 30064771125;
								HIDKeyboardModifierMappingSrc = 30064771172;
							}
						];
					};
				};

				# Used for backwards compatibility, please read the changelog before changing.
				# $ darwin-rebuild changelog
				system.stateVersion = 6;

				# The platform the configuration will be used on.
				nixpkgs.hostPlatform = "aarch64-darwin";

			};
		in
			{
			# Build darwin flake using:
			# $ darwin-rebuild build --flake .#simple
			darwinConfigurations."raivokinne" = nix-darwin.lib.darwinSystem {
				modules = [
					configuration
					home-manager.darwinModules.home-manager
					nix-homebrew.darwinModules.nix-homebrew
					{
						nix-homebrew = {
							enable = true;
							enableRosetta = true;
							user = "raivokinne";
						};
					}
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.extraSpecialArgs = {
							pkgsUnstable = nixpkgs-unstable.legacyPackages.aarch64-darwin;
						};
						home-manager.users.raivokinne = import ./home.nix;
					}
				];
			};

			# Expose the package set, including overlays, for convenience.
			darwinPackages = self.darwinConfigurations."raivokinne".pkgs;
		};
}
