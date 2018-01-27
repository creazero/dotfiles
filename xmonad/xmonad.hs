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
import XMonad.Layout.Minimize

-- PROMPT
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Pass
import XMonad.Prompt.Window

-- UTIL
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Scratchpad

----------------------------------
-- Terminal
myTerminal = "/usr/local/bin/alacritty"

-- Screenshot
mySelectScreenshot = "screenshot-area"
myScreenshot       = "screenshot"

-- Launcher
myLauncher = "rofi -show run"

-- Workspaces
--myWorkspaces = map show [1..9]
myWorkspaces = ["tmx", "www", "wrk", "med", "tgm"]

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.15     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 1 - h   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%

-- Manage Hook
myManageHook = composeAll
    [ className =? "TelegramDesktop" --> doShift "tgm"
    , className =? "mpv"             --> doFloat
    , className =? "Pavucontrol"     --> doFloat
    , className =? "Thunar"          --> doFloat
    , className =? "Steam"           --> doFloat
    , manageDocks
    , manageScratchPad
    ]

myLayout = minimize $
           smartBorders (
               aTiled     |||
               aFullTiled |||
               aFullScreen)
            where
                aTiled      = named "mtiled"  ( avoidStruts $ gaps [(U,5), (R,5), (L,5), (D,5)] $ ResizableTall nmaster delta ratio [] )
                aFullScreen = named "mfullscreen" ( noBorders(fullscreenFull Full) )
                aFullTiled  = named "mfulltiled" ( avoidStruts $ noBorders $ fullscreenFull Full)
                nmaster = 1
                delta   = 5/100
                ratio   = 1/2

-- Borders
myNormalBorder  = "#151515"
myFocusedBorder = "#8787af"

-- Tabbed tabs config
tabConfig = defaultTheme
    { activeBorderColor   = "#8fbfdc"
    , activeTextColor     = "#282c34"
    , activeColor         = "#8fbfdc"
    , inactiveBorderColor = "#151515"
    , inactiveTextColor   = "#abb2bf"
    , inactiveColor       = "#151515"
    }

-- Theme for Prompt
myPromptTheme :: XPConfig
myPromptTheme = defaultXPConfig
    { font = "xft:Ubuntu Mono-16"
    , bgColor = "#151515"
    , fgColor = "#ffffff"
    , borderColor = "#ffffff"
    , historySize = 5
    , height = 25
    , position = Top
    , promptBorderWidth = 0
    , promptKeymap = emacsLikeXPKeymap
    , alwaysHighlight = True
    , searchPredicate = isInfixOf
    }

-- Width of the window border
myBorderWidth = 2

-- Color of current window title in xmobar.
xmobarTitleColor = "#963c59"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#963c59"

-- Key Binding
myModMask = mod4Mask

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

main = do
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
            , ((myModMask .|. shiftMask, xK_l),            spawn "lock -l")
            , ((myModMask,               xK_i),            spawn "~/.bin/info")
            , ((myModMask,               xK_n),            spawn "~/.bin/mpc_info")
            , ((myModMask .|. shiftMask, xK_o),            scratchpadSpawnActionTerminal "urxvt")
            , ((myModMask,               xK_e),            spawn "emacsclient")
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
    , handleEventHook    = Ewm.fullscreenEventHook <+> minimizeEventHook
    , startupHook        = setWMName "LG3D"
    }
