.PHONY: update
update:
	sudo nixos-rebuild --impure switch --flake .#vch
	# home-manager switch --flake .#vch

.PHONY: clean
clean:
	nix-collect-garbage -d
