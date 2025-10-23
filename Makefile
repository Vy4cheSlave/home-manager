.PHONY: update
update: # правило написаное кровью
	git add .
	GIT_VERSION="$(date -u +'%Y-(%m-%B)-(%d-%A) %H:%M')"
	git commit -m "$GIT_VERSION"
	git push origin nixos
	sudo nixos-rebuild --impure switch --flake .#vch

.PHONY: clean
clean:
	sudo nix-collect-garbage -d

.PHONY: list-generations
list-generations:
	sudo nixos-rebuild list-generations