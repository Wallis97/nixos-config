{ ... }:
{
  # NetworkManager connections configuration
  networking = {
    hostName = "nixos-homelab";
    networkmanager = {
      enable = true;
      ensureProfiles.profiles = {
        "enp2s0-parent" = {
          connection = {
            id = "enp2s0-parent";
            type = "ethernet";
            interface-name = "enp2s0";
            autoconnect = true;
          };
          ipv4.method = "disabled";
          ipv6.method = "disabled";
        };
        "host0" = {
          connection = {
            id = "host0";
            type = "macvlan";
            interface-name = "host0";
            autoconnect = true;
          };
          macvlan = {
            parent = "enp2s0";
            mode = "bridge";
            tap = false;
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };
      };
    };
  };

  # Cofigure kernel for network bridging
  boot = {
    kernelModules = [
      "br_netfilter"
      "macvlan"
    ];
    kernel.sysctl = {
      "net.bridge.bridge-nf-call-ip6tables" = 0;
      "net.bridge.bridge-nf-call-iptables" = 0;
      "net.bridge.bridge-nf-call-arptables" = 0;
      "net.ipv4.ip_forward" = 1;
    };
  };
}
