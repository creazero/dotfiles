import XMonad
import XMonad.Hooks.DynamicLog
import qualified XMonad.Hooks.EwmhDesktops as Ewm
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

-- Screensaver (someday)
-- myScreensaver = 

-- Screenshot
mySelectScreenshot = "scrot -s"
myScreenshot       = "scrot -q 100"

-- Launcher
myLauncher = "rofi -show run"

-- Workspaces
myWorkspaces = ["term", "www", "code", "media", "tm"] ++ map show [6..9]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
--myEventHook = mempty
--myEventHook = ewmhDesktopsEventHook <+> E.fullscreenEventHook <+> fullscreenEventHook

-- Manage Hook
myManageHook = composeAll
    [ className =? "TelegramDesktop" --> doFloat
    , className =? "TelegramDesktop" --> doShift "tm"
    , className =? "mpv"             --> doFloat
    , className =? "mpv"             --> doShift "media"
    , className =? "Pavucontrol"     --> doFloat
    , className =? "Pcmanfm"         --> doFloat
    ]

myLayout = smartBorders $ avoidStruts (tiled ||| tabbed shrinkText tabConfig) ||| noBorders (fullscreenFull Full)
    where
        tiled = spacing 5 $ Tall nmaster delta ratio
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

------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
                         
------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
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
            [ ((myModMask,               xK_s),            spawn "pcmanfm")
            , ((myModMask,               xK_Print),        spawn mySelectScreenshot)
            , ((myModMask .|. shiftMask, xK_Print),        spawn myScreenshot)
            , ((myModMask,               xK_p),            spawn "mpc toggle")
            , ((myModMask,               xK_bracketright), spawn "mpc next")
            , ((myModMask,               xK_bracketleft),  spawn "mpc prev")
            , ((myModMask,               xK_d),            spawn myLauncher)
            , ((myModMask .|. shiftMask, xK_Return),       spawn myTerminal)
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
