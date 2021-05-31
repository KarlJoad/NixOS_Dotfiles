{ config, pkgs, lib, ... }:
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
    browsing = true;
    listenAddresses = [ "*:631" ];
    defaultShared = true;
  };

  # Enable automatic discovery of the printer from other Linux systems also running Avahi
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  networking.firewall.allowedUDPPorts = [ 631 ];
  networking.firewall.allowedTCPPorts = [ 631 ];
}
