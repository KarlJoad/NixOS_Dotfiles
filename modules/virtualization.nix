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
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  users.extraGroups.vboxusers.members = [ "karl" ];
}
