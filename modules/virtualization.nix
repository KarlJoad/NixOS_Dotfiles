{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virt-manager
    # xen
  ];

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    # xen.enable = true;
    virtualbox.host = {
      enable = false;
      enableExtensionPack = false;
    };
  };

  users.extraGroups.vboxusers.members = [ "karl" ];
}
