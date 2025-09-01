{ pkgs, inputs, myUtils, lib, ... }:

{

	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		./modules/nixos
	];

	boot = {
		kernelPackages = pkgs.linuxPackages_zen;

		kernelParams = [ "quiet" ];
		kernelModules = [
			"cpuid"
		];
	};

	# Replace missing disk swap with zram swap to avoid boot timeout
	zramSwap = {
		enable = true;
		memoryPercent = 50;
	};

	# Force-disable old swapDevices defined by hardware-configuration.nix (UUID no longer exists)
	swapDevices = lib.mkForce [];

	# Home Manager users (co-located with system root)
	home-manager.users.admin = { ... }: {
		imports = [
			./home.nix
			./modules/home-manager
		];
	};

	# System users (simple inline style)
	users.users.admin = {
		isNormalUser = true;
		initialPassword = "password";
		description = "admin";
		shell = pkgs.fish;
		extraGroups = [ "networkmanager" "wheel" "docker" "i2c" ];
	};

	users.groups.docker.members = [ "admin" ];
	users.groups.i2c.members = [ "admin" ];

	networking.hostName = "p620";
	networking.networkmanager.enable = true;

	time.timeZone = "America/Chicago";

	services = {
		libinput.enable = true;
		printing.enable = true;
		openssh.enable = false;
	};

	environment.systemPackages = with pkgs; [
		home-manager
	];

	system.stateVersion = "25.05";
}


