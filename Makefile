.PHONY: update
update:
	home-manager switch --flake .#vch

.PHONY: clean
clean:
	nix-collect-garbage -d
