{ config, pkgs, ... }:

{
	# Enable Raspberry Pi non free firmware blobs
	hardware.enableRedistributableFirmware = true;

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-label/NIXOS_SD";
			fsType = "ext4";
		};
	};
	swapDevices = [{
		device = "/swap";
		size = 1024;
	}];

	# Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
	boot.loader.grub.enable = false;
	# Enables the generation of /boot/extlinux/extlinux.conf
	boot.loader.generic-extlinux-compatible.enable = true;

	boot.kernelPackages = pkgs.linuxPackages_latest;

	# Enable wireless networking
	networking.wireless.enable = false;
	# Networking configuration
	networking.useDHCP = false;
	networking.interfaces.eth0.useDHCP = true;
	networking.interfaces.wlan0.useDHCP = true;
	networking.hostName = "rspbpi3b-hydrogen";

 	i18n = {
		 consoleKeyMap = "de";
		 defaultLocale = "en_GB.UTF-8";
	 };

	time.timeZone = "Europe/Berlin";
	
	environment.systemPackages = with pkgs; [
		vim git
	];

	environment.etc."gitconfig".text = ''
		[user]
		name = Benjamin Asbach
		email = asbachb@users.noreply.github.com
	'';

 	services.openssh.enable = true;

	# Firewall.
	networking.firewall.allowedTCPPorts = [ 22 ];
	networking.firewall.allowedUDPPorts = [ ];

	users.users.asbachb = {
		isNormalUser = true;
		hashedPassword = "$6$43Kcp7PAPh$GFA1ZEKl8rTO20BqsUutAI6VbT0nIhSUdEks.gu7mcUN9.vNqxbl3yYXiAXK2v4cEQ/GDyjTFyaVBa2Uj.BmH1";
		extraGroups = [ "wheel" ];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICCcIfPhf36gbN8W3zUN40E0u+Y9x/KR+mvb3rhT11SB asbachb@desktop-hp-8200-elite"
		];
	};

	# This value determines the NixOS release with which your system is to be
	# compatible, in order to avoid breaking some software such as database
	# servers. You should change this only after NixOS release notes say you
	# should.
	system.stateVersion = "19.09"; # Did you read the comment?
}

