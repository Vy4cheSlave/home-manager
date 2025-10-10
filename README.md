home-manager

---

#### home.nix parameters Documentation

man home-configuration.nix

---

#### dependencies

git
make
[nix](https://nixos.org/download.html)

---

#### start

cd ~

git clone ...

ehco 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf 

cd ~/home-manager

nix-shell -p home-manager

make update

exit

---

#### patching

after patch

git add .

make update

---

#### cleaning system

make clean

