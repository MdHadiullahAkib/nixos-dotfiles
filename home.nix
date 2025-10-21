{ config, pkgs, ... }: 

{
	home.username = "akib";
	home.homeDirectory = "/home/akib";
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo i use hyprland btw";
			balkama = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-minipc-btw";
		};
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
				exec Hyprland
			fi
		'';
	};
	programs = {
	   nushell.enable = true;  
	#   carapace.enable = true;
	#   carapace.enableNushellIntegration = true;

	#   starship = { enable = true;
	#       settings = {
	#	 add_newline = true;
	#	 character = { 
	#	   success_symbol = "[➜](bold green)";
	#	   error_symbol = "[➜](bold red)";
	#         };
	#      };
	#   };
	};
	#home.file.".config/hypr".source = ./config/hypr;
}
