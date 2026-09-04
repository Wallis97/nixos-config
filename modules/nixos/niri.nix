{ inputs, ... }:
{
  imports = [

  ];

  # # # Niri
  # programs.dank-material-shell = {
  #   enable = true;
  #   niri = {
  #     enableKeybinds = true;
  #     enableSpawn = true;
  #   };
  # };



  systemd.user.services = {
    niri = {
      enable = true;
      wants = [
        "mako.service"
        "waybar.service"
      ];
    };
  };
}
