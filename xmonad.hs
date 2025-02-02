import XMonad
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Hooks.FadeInactive
import XMonad.Layout.ThreeColumns 
import XMonad.Layout.Renamed


main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ myConfig

-- Win key
myModMask     = mod4Mask

myTerminal    = "kitty"

myFocusBorder = "#97DCBE"
myBorder      = "#2C8537"
myPadding     = 4 

myConfig = def
  { terminal           = myTerminal
  , modMask            = myModMask
  , manageHook         = myManageHook
  , layoutHook         = myLayoutHook
  , logHook            = myLogHook
  , normalBorderColor  = myBorder
  , focusedBorderColor = myFocusBorder
  }
  `additionalKeysP`
  myKeys

myKeys =
    [
      ( "M-<Space>",               spawn "dmenu_run")
    , ( "M-S-p",                   sendMessage $ JumpToLayout "Full")
    , ( "M-p",                     sendMessage NextLayout)
    , ( "M-S-l",                   spawn "xscreensaver-command -lock")
    , ( "<XF86AudioRaiseVolume>",  spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ( "<XF86AudioLowerVolume>",  spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ( "<XF86AudioMute>",         spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ( "<XF86AudioMicMute>",      spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    , ( "<XF86MonBrightnessUp>",   spawn "lux -a 10%")
    , ( "<XF86MonBrightnessDown>", spawn "lux -s 10%")
    , ( "M-f",                     spawn "firefox")
    , ( "M-v",                     spawn "virt-manager")
    ]

myLayout = tiled ||| threeColumns ||| Full 
  where
    threeColumns = named "Col" $ ThreeColMid nmaster delta ratio
    tiled    = named "Tile" $ Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

mySpacing = spacingWithEdge

myLayoutHook = renamed [CutWordsLeft 1] $
  smartBorders . avoidStruts $
  mySpacing myPadding $
  myLayout 

myManageHook = composeAll [ manageDocks,
                            isFullscreen --> doFullFloat,
                            manageHook def
                          ]

myLogHook = fadeInactiveLogHook fadeAmount
  where
    fadeAmount = 0.9 
