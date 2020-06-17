{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    msmtp # For sending mail using SMTP
    isync # Project name. Binary is mbsync
    # unstable.mu
    mu
  ];
}
