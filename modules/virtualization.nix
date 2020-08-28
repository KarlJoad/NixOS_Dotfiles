{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virt-manager
    # xen docker
  ];

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    # xen.enable = true;
  };
}
