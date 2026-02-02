{
	description = "nixos with flake homemanager and hyprland";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		stable.url = "github:nixos/nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = { self, nixpkgs, stable, home-manager, ... }: {
		nixosConfigurations.nixos-minipc-btw = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				({ pkgs, ... }: {
					nixpkgs = { overlays = [(self: super: { stable = import stable { system = "x86_64-linux"; }; }) ]; };
				})
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.akib = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
