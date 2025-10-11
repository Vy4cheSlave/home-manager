# home-manager

> ## [!info] No NixOS 

### home.nix parameters Documentation

`man home-configuration.nix`

---

### dependencies

`git`

`make`

[nix](https://nixos.org/download.html) (я пользуюсь Single-user installation)

---

### start

[4 пункт обяязательно (не знаю пока нахуя только)](https://nix-community.github.io/home-manager/index.xhtml#ch-installation)

```sh
cd ~

mkdir -p ~/.config/nix && ehco 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf 

git clone this repo

cd ~/home-manager

nix-shell -p home-manager

make update

exit
```

---

### patching

after patch

```sh
git add .

make update
```

---

### cleaning system

```sh
make clean
```
