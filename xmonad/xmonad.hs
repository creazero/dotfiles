import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops as Ewm
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Util.EZConfig
import XMonad.Util.Run
----------------------------------
-- Terminal
myTerminal = "/usr/bin/urxvt"

-- Screenshot
mySelectScreenshot = "screenshot-area"
myScreenshot       = "screenshot"

-- Launcher
myLauncher = "rofi -show run"

-- Workspaces
myWorkspaces = ["term", "www", "code", "media", "tm"] ++ map show [6..9]

-- Manage Hook
myManageHook = composeAll
    [ className =? "TelegramDesktop" --> doFloat
    , className =? "TelegramDesktop" --> doShift "tm"
    , className =? "mpv"             --> doFloat
    , className =? "mpv"             --> doShift "media"
    , className =? "Pavucontrol"     --> doFloat
    , className =? "Thunar"          --> doFloat
    , className =? "discord"         --> doFloat
    ]

myLayout = smartBorders $ avoidStruts (tiled ||| tabbed shrinkText tabConfig) ||| noBorders (fullscreenFull Full)
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 3/100

-- Borders
myNormalBorder  = "#151515"
myFocusedBorder = "#262626"

-- Tabbed tabs config
tabConfig = defaultTheme
    { activeBorderColor   = "#8fbfdc"
    , activeTextColor     = "#282c34"
    , activeColor         = "#8fbfdc"
    , inactiveBorderColor = "#151515"
    , inactiveTextColor   = "#abb2bf"
    , inactiveColor       = "#151515"
    }

-- Width of the window border
myBorderWidth = 2

-- Color of current window title in xmobar.
xmobarTitleColor = "#8fbfdc"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#8fbfdc"

-- Key Binding
myModMask = mod4Mask

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
                         
main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ docks defaults
        { logHook = dynamicLogWithPP $ xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor xmobarTitleColor "" . shorten 50
            , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
            , ppSep = "   "
            , ppLayout  = \_ -> ""
            }
        , manageHook = manageDocks <+> myManageHook
        , startupHook = setWMName "LG3D"
        } `additionalKeys`
            [ ((myModMask,               xK_s),            spawn "thunar")
            , ((myModMask,               xK_Print),        spawn mySelectScreenshot)
            , ((myModMask .|. shiftMask, xK_Print),        spawn myScreenshot)
            , ((myModMask,               xK_p),            spawn "mpc toggle")
            , ((myModMask,               xK_bracketright), spawn "mpc next")
            , ((myModMask,               xK_bracketleft),  spawn "mpc prev")
            , ((myModMask,               xK_d),            spawn myLauncher)
            , ((myModMask .|. shiftMask, xK_Return),       spawn myTerminal)
            , ((myModMask .|. shiftMask, xK_l),            spawn "i3lock-fancy")
            ]

defaults = defaultConfig
    { terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorder
    , focusedBorderColor = myFocusedBorder

    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , handleEventHook    = Ewm.fullscreenEventHook
    }
