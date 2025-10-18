{ config, lib, pkgs, ... }:

{
	imports =
  		[ 
    			./hardware-configuration.nix
  		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernelParams = [ "usbcore.autosuspend=-1" ];
	boot.supportedFilesystems = [ "ntfs" "btrfs" "exfat" "xfs" ];

	networking.hostName = "nixos-minipc-btw"; 
	networking.networkmanager.enable = true;  

	time.timeZone = "Asia/Dhaka";

	services.pulseaudio.enable = false;
	services.getty.autologinUser = "akib";
	services.openssh.enable = true;
	services.blueman.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	security.rtkit.enable = false;

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

  	users.users.akib = {
    		isNormalUser = true;
		extraGroups = [ "wheel" "libvirtd" "disk" "storage"  ];
    		packages = with pkgs; [
      			tree
    		];
  	};

  	environment.systemPackages = with pkgs; [
		btop
		bluez
		cliphist
		fzf
		gcc
    		git
		gparted
    		hyprpaper
    		kitty
		mpv
		neovim
    		qutebrowser
		rofi
		unzip
    		vim 
    		waybar
		wl-clipboard
    		wget
		yazi
		yaziPlugins.sudo
		yaziPlugins.mount
		yaziPlugins.mediainfo
		yaziPlugins.recycle-bin
		yaziPlugins.wl-clipboard
		yaziPlugins.relative-motions
		yt-dlp
		zoxide	
        
  	];
	fonts.packages = with pkgs;[
		nerd-font-patcher
		nerd-fonts.fira-code
		nerd-fonts.droid-sans-mono
		nerd-fonts.jetbrains-mono
	];

	programs.virt-manager.enable = true;
	virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];
	virtualisation.spiceUSBRedirection.enable = true;
	virtualisation.libvirtd = {
		enable = true;
		qemu = {
			package = pkgs.qemu_kvm;
			runAsRoot = true;
			swtpm.enable = true;
		};
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

  	system.stateVersion = "25.05"; 
}
