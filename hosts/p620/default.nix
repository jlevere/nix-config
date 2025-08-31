{ pkgs, inputs, myUtils, ... }:

{

	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		../../modules/nixos
	];

	boot = {
		kernelPackages = pkgs.linuxPackages_zen;

		kernelParams = [ "quiet" ];
		kernelModules = [
			"coretemp"
			"cpuid"
		];
	};

	# Home Manager users
	home-manager.users.admin = { ... }: {
		imports = [
			(import ../../users/admin/home.nix)
			../../modules/home-manager
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

	services = {
		libinput.enable = true;
		printing.enable = true;
		openssh.enable = false;
	};

	system.stateVersion = "25.05";
}
