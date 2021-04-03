set-channel:
	sudo nix-channel --add https://nixos.org/channels/nixos-20.09 nixos
	sudo nix-channel --update

build:
	sudo nixos-rebuild build

switch:
	sudo nixos-rebuild switch

upgrade:
	sudo nixos-rebuild switch --upgrade

.PHONY: build switch upgrade set-channel
