{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "vch";
    homeDirectory = "/home/vch";

    stateVersion = "25.05";
  };
}
