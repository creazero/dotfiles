Config { font = "xft:Terminus-10"
       , additionalFonts = []
       , borderColor = "#282c34"
       , border = NoBorder
       , bgColor = "#0c0d0e"
       , fgColor = "#b7b8b9"
       , alpha = 255
       , position = Static { xpos = 0 , ypos = 0, width = 1805, height = 23 }
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = False
       , overrideRedirect = True
       , commands = [ Run Date "%_d %b %H:%M" "date" 10
                    , Run MPD ["-t", "<artist> - <title>"] 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{%mpd% | %date% "
       }
