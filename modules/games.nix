{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    minecraft
  ];
}
