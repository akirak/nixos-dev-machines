build:
	sudo nixos-rebuild build

switch:
	sudo nixos-rebuild switch

upgrade:
	sudo nixos-rebuild switch --upgrade

.PHONY: build switch upgrade
