{ inputs, ... }:
{
  imports = [ inputs.microvm.nixosModules.host ];

  microvm = {
    host.enable = true;
    stateDir = "/var/lib/microvms";
    autostart = [
      "controlplane"
    ];
  };
}
