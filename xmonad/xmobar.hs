Config { font = "xft:lucy tewi-8"
       , additionalFonts = []
       , borderColor = "#282c34"
       , border = TopB
       , bgColor = "#000000"
       , fgColor = "#ffffff"
       , alpha = 255
       , position = Static { xpos = 0 , ypos = 0, width = 1920, height = 25 }
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run Date "%_d %b %H:%M" "date" 10
                    , Run MPD ["-t", "<artist> - <title>"] 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{%mpd% | %date% "
       }
