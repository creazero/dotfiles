import XMonad
import qualified XMonad.StackSet as W
import Data.List

-- ACTIONS
import XMonad.Actions.WindowMenu

-- HOOKS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops as Ewm
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.Minimize
import XMonad.Hooks.SetWMName

-- LAYOUTS
import XMonad.Layout.Gaps
import XMonad.Layout.Fullscreen
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile

-- PROMPT
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Pass
import XMonad.Prompt.Window

-- UTIL
import XMonad.Util.EZConfig
import XMonad.Util.Run

----------------------------------
-- Terminal
myTerminal = "/usr/local/bin/alacritty"

-- Screenshot
mySelectScreenshot = "~/.bin/screenshot-area"
myScreenshot       = "~/.bin/screenshot both"
currentMonitorScr  = "~/.bin/screenshot one"

-- Launcher
myLauncher = "dmenu_run -fn 'Menlo-16'"

-- Workspaces
--myWorkspaces = map show [1..9]
myWorkspaces = ["tmx", "www", "wrk", "med", "tgm"] ++ ["6","7"]

-- Manage Hook
myManageHook = composeAll
    [ className =? "TelegramDesktop" --> doShift "tgm"
    , className =? "mpv"             --> doFloat
    , className =? "Pavucontrol"     --> doFloat
    , className =? "Thunar"          --> doFloat
    , className =? "Pcmanfm"         --> doFloat
    , className =? "Steam"           --> doFloat
    , className =? "stalonetray"     --> doIgnore
    , manageDocks
    ]

myLayout = smartBorders (
               aTiled     |||
               aFullTiled |||
               aFullScreen)
            where
                aTiled      = named "mtiled"  ( avoidStruts $ ResizableTall nmaster delta ratio [] )
                aFullScreen = named "mfullscreen" ( noBorders $ fullscreenFull Full )
                aFullTiled  = named "mfulltiled" ( avoidStruts $ noBorders $ fullscreenFull Full)
                nmaster = 1
                delta   = 5/100
                ratio   = 1/2

-- Borders
myNormalBorder :: String
myNormalBorder  = "#2c2c2c"

myFocusedBorder :: String
myFocusedBorder = "#3182bd"

-- Width of the window border
myBorderWidth = 2

-- Color of current window title in xmobar.
xmobarTitleColor :: String
xmobarTitleColor = "#ffffff"

-- Color of current workspace in xmobar.
-- xmobarCurrentWorkspaceColor = "#3182bd"
xmobarCurrentWorkspaceColor = "#ffffff"

xmobarUrgentColor = "#e31a1c"

-- Key Binding
myModMask = mod4Mask

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

main = do
    --xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar-dual.hs"
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad
        $ docks
        $ fullscreenSupport
        $ ewmh defaults
        { logHook = dynamicLogWithPP $ xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor xmobarTitleColor "" . shorten 50
            , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
            , ppSep = "   "
            , ppLayout  = \x -> x
            , ppUrgent = xmobarColor (wrap "!" "!" xmobarUrgentColor) ""
            , ppHiddenNoWindows = \x -> wrap "_" "_" x
            }
        , manageHook = manageDocks <+> myManageHook
        } `additionalKeys`
            [ ((myModMask .|. shiftMask,   xK_s),            spawn "pcmanfm")
            , ((myModMask,                 xK_Print),        spawn mySelectScreenshot)
            , ((myModMask .|. shiftMask,   xK_Print),        spawn myScreenshot)
            , ((myModMask .|. controlMask, xK_Print),        spawn currentMonitorScr)
            , ((myModMask,                 xK_p),            spawn "mpc toggle")
            , ((myModMask,                 xK_bracketright), spawn "mpc next")
            , ((myModMask,                 xK_bracketleft),  spawn "mpc prev")
            , ((myModMask,                 xK_d),            spawn myLauncher)
            , ((myModMask .|. shiftMask,   xK_Return),       spawn myTerminal)
            , ((myModMask .|. shiftMask,   xK_l),            spawn "lock -l")
            , ((myModMask .|. shiftMask,   xK_o),            spawn "alacritty --config-file '/home/creazero/.athemes/dark-tf.yml' -e 'nvim' ")
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
    , startupHook        = setWMName "LG3D"
    }
