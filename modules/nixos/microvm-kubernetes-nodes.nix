{ inputs, ... }:
{
  imports = [ inputs.microvm.nixosModules.host ];

  microvm.vms = {
    controlplane = {
      config = { ... }: {
        networking = {
          hostName = "nixos-vm-controlplane";
          networkmanager.enable = true;
        };

        services.openssh.enable = true;
        programs.ssh.startAgent = true;
        users.users.vallii = {
          isNormalUser = true;
          description = "vallii";
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJVV2qV5OJzkw6o20/BxVlB0OkBq43wirlGa/gEafzzT vallii@nixos"
          ];
        };

        microvm = {
          hypervisor = "qemu";
          vcpu = 2;
          mem = 2024;

          interfaces = [
            {
              type = "macvtap";
              id = "vm-cp-macvtap0";
              mac = "02:00:00:00:00:01";
              macvtap = {
                link = "enp2s0";
                mode = "bridge";
              };
            }
          ];
          volumes = [
            {
              mountPoint = "/var";
              image = "var.img";
              size = 30;
            }
          ];
          shares = [
            {
              source = "/nix/store";
              mountPoint = "/nix/.ro-store";
              tag = "ro-store";
              proto = "virtiofs";
            }
          ];
        };
      };
    };
    # worker-node = {
    #   config = { config, pkgs, ... }: {

    #   };
  };
}
