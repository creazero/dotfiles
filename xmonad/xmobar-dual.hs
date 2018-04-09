-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- https://github.com/vicfryzel/xmonad-config

-- This xmobar config is for dual 2560x1440 displays and meant to be used with
-- the stalonetrayrc-dual config.
--
-- If you're using dual displays with different resolutions, adjust the
-- position argument below using the given calculation.
Config {
    -- Position xmobar along the top, with stalonetray in the top right.
    -- Shrink xmobar width to ensure stalonetray and xmobar don't overlap.
    -- stalonetrayrc-dual is configured for 12 icons, each 19px wide.
    -- Because of the dual display setup, we statically position xmobar.
    -- Each display is 2560px wide. Offset left (x position) by one width.
    -- xpos = display_width = 2560
    -- If your left display is primary, then set xpos = 0.
    -- ypos = 0 (top)
    -- width = display_width - (num_icons * icon_width)
    -- width = 2560 - (12 * 19) = 2332
    -- height = 19
    position = Static { xpos = 1920, ypos = 0, width = 1805, height = 23 },
    font = "xft:Roboto-11",
    bgColor = "#0c0d0e",
    fgColor = "#b7b8b9",
    lowerOnStart = True,
    overrideRedirect = True,
    -- We don't want xmobar on all desktops in a dual display setup.
    allDesktops = False,
    persistent = False,
    commands = [
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Network "enp3s0" ["-t","Net: <dev>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Date "%a %b %_d %H:%M" "date" 10,
        Run MPD ["-t", "<artist> - <title>"] 10,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %mpd%   %memory%   %enp3s0%   <fc=#FFFFCC>%date%</fc>"
}
