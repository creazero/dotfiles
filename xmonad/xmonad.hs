import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M

import System.Exit

import XMonad.Actions.WorkspaceNames

-- HOOKS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops as Ewm
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName

-- LAYOUTS
import XMonad.Layout.Fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Layout.DragPane

-- UTIL
import XMonad.Util.EZConfig
import XMonad.Util.Run

----------------------------------
-- Terminal
myTerminal :: String
myTerminal = "urxvt"

-- Screenshot
mySelectScreenshot :: String
myScreenshot :: String
currentMonitorScr :: String
mySelectScreenshot = "~/.bin/screenshot-area"
myScreenshot       = "~/.bin/screenshot both"
currentMonitorScr  = "~/.bin/screenshot one"

-- Launcher
myLauncher :: String
--myLauncher = "dmenu_run -fn 'Menlo-16'"
myLauncher = "rofi -combi-modi run,drun,window -show combi -modi combi"

-- Workspaces
myWorkspaces :: [String]
myWorkspaces = ["tmx", "www", "wrk", "med", "tgm"] ++ ["6","7"]

-- Manage Hook
myManageHook = composeAll
    [ className =? "Google-chrome"   --> doShift "www"
    , className =? "mpv"             --> doFloat
    , className =? "smplayer"        --> doFloat
    , className =? "Pavucontrol"     --> doFloat
    , className =? "Thunar"          --> doFloat
    , className =? "Pcmanfm"         --> doFloat
    , className =? "Steam"           --> doFloat
    , className =? "Telegram"        --> doFloat
    , className =? "TelegramDesktop" --> doFloat
    , className =? "Slack"           --> doFloat
    , className =? "Lxtask"          --> doFloat
    , className =? "discord"         --> doFloat
    , className =? "Oblogout"        --> doFloat
    , className =? "stalonetray"     --> doIgnore
    , manageDocks
    ]

myLayout = smartBorders (
                   aTiled     |||
                   aFullTiled |||
                   aVertical  |||
                   aTabbed    |||
                   aFullScreen)
            where
                aTiled      = named "mtiled"  ( avoidStruts $ ResizableTall nmaster delta ratio [] )
                aFullScreen = named "mfullscreen" ( noBorders $ fullscreenFull Full )
                aFullTiled  = named "mfulltiled" ( avoidStruts $ noBorders $ fullscreenFull Full)
                aVertical   = named "mvertical" ( avoidStruts $ dragPane Horizontal 0.1 0.5)
                aTabbed     = named "mtabbed" ( avoidStruts $ tabbed shrinkText tabConfig)
                nmaster = 1
                delta   = 5/100
                ratio   = 1/2

tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000",
    fontName      = "xft:xos4 Terminus-9"
}

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

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
  , ((modMask, xK_p),
     spawn myLauncher)

  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask, xK_Tab),
     windows W.focusDown)

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap.
  -- TODO: update this binding with avoidStruts, ((modMask, xK_b),

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

 
main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar-single.hs"
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
            , ((myModMask .|. shiftMask,   xK_l),            spawn "i3lock -ti ~/Wallpapers/sadness.png")
            , ((myModMask .|. controlMask, xK_e),            spawn "emacs")
            , ((myModMask .|. controlMask, xK_t),            spawn "telegram-desktop")
            , ((myModMask .|. controlMask, xK_s),            spawn "slack")
            , ((myModMask .|. controlMask, xK_p),            spawn "pavucontrol")
            ]

defaults = def
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
    , keys = myKeys
    }
