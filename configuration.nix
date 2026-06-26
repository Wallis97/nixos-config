# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      inputs.nixops4.modules.flake.default 
    ];

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  # Dual boot config.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      };
    };
  time.hardwareClockInLocalTime = true;
  
  # Kernel parameters
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
    '';

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "pl";
    useXkbConfig = true; # use xkb.options in tty.
  };

  users.users.vallii = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # List of fonts
  # fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.maple-mono);

  programs.firefox.enable = true;
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "0";

  programs.hyprland.enable = true;

  # Set polish keyboard layout
  services.xserver.xkb.layout = "pl";

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    gh
    waybar
    hyprpaper
    pavucontrol
    freshfetch
    kitty
    rose-pine-hyprcursor
    vscode
    pywal16
    pywalfox-native
    spotify
    hyprshot
    hyprnotify
    cava
    peaclock
    eww
    rpi-imager
    wofi
    mako
    nmap
    kubectl
    kubernetes-helm
    beeper
    zed-editor
    dig
    oh-my-posh
    (discord.override {
      withVencord = true;
      })
  ];

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome = {
      core-apps.enable = false;
      games.enable = false;
#      core-developer-tools.enable = false;
    };
  };

  # PulseWire configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    };

  # bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
	};
      };
    };
  services.blueman.enable = true;
  services.pipewire.wireplumber.enable = true;

  # Nvidia config
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      };
    };

  services.xserver = {
    videoDrivers = ["nvidia"];
   # enable = true;
    };

  # Enable Tailscale
  services.tailscale.enable = true;
  services.resolved.enable = true;

  # Automatic upgrades 
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    };

  # Virt-manager configuration
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["vallii"];
  virtualisation.spiceUSBRedirection.enable = true;


  system.stateVersion = "25.05"; # Did you read the comment?

}

