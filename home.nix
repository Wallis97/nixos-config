{ config, pkgs, ... }:

{
  home = {
    username = "vallii";
    homeDirectory = "/home/vallii";

   stateVersion = "25.05";
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
    useTheme = "gruvbox";
    };

  # bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    };

  # hyprland configuration
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
	bind = [
	  "$mod, Q, exec, kitty"
          "$mod, R, exec, wofi --show drun"
	  "$mod, C, killactive, "
	  "$mod, M, exit, "
	  "$mod, V, togglefloating,"
	  "$mod, J, togglesplit,"

	  # move windows to workspaces L/R
	  "$mod SHIFT, right, movetoworkspace, e+1"
	  "$mod SHIFT, left, movetoworkspace, e-1"

	  # Move focus with mod + arrow keys
          "$mod, left, movefocus, l"
	  "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

	  # hyprshot shortcuts
	  "$mod, PRINT, exec, hyprshot -m window --clipboard-only"
          ", PRINT, exec, hyprshot -m output --clipboard-only"
          "$mod, S, exec, hyprshot -m region --clipboard-only"
	  ]
	  ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
	);
	bindm = [
	# Resize windows with mod + mouse buttons
	  "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
	  ];
        bindel = [
	  ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	];
	bindl = [
	  ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
	];
	
      };
	extraConfig = ''
	  input {
	    exec-once = mako &


	    kb_layout = pl
	  }
	'';
    };


  programs.home-manager.enable = true;
}
