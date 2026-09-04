{ ... }:

{
  home = {
    username = "vallii";
    homeDirectory = "/home/vallii";
    stateVersion = "26.11";
  };

  # kitty configuration
  programs.kitty = {
    enable = true;
    extraConfig = ''
      confirm_os_window_close 0
      backgroun_blur 1
      background_opacity 0.7
    '';
  };

  # oh-my-posh configuration
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    configFile = "~/.config/oh-my-posh/gruvbox.omp.json";
  };

  # bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.home-manager.enable = true;
}
