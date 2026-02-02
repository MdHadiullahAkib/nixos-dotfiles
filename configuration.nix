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

    boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
    ];
    boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    networking.hostName = "nixos-minipc-btw"; 
    networking.networkmanager.enable = true;  
    time.timeZone = "Asia/Dhaka";
    services.gvfs.enable = true;
    services.udisks2.enable = true;
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
    programs.hyprlock.enable = true;
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };
    environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        SUDO_EDITOR = "nvim";
        SYSTEMD_EDITOR = "nvim";
    };
    users.users.akib = {
        isNormalUser = true;
        shell = pkgs.nushell;
        extraGroups = [ "wheel" "libvirtd" "disk" "storage"  ];
        packages = with pkgs; [
            tree
        ];
    };
    environment.systemPackages = with pkgs; [
        ani-cli
        aria2
        btop
        bluez
        carapace
        cliphist
        fzf
        gcc
        git
        glib
        gparted
        hypridle
        hyprpolkitagent
        hyprpaper
        jmtpfs
        stable.kdePackages.kdenlive
        kitty
        mpv
        neovim
        qutebrowser
        rofi
        scrcpy
        starship
        trash-cli
        unzip
        vim 
        waybar
        wlogout
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
        ytfzf
        zoxide	
        #neovim require
        ripgrep
        fd
        gnumake
        nodejs_24
        python3
        rustup
        lua
        luajitPackages.luarocks-nix
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
