-- Jeudine's xmonad.hs

import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import System.IO
import XMonad.Util.Run(spawnPipe)

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

-- Layouts
import XMonad.Layout
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- Keyboard
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)

-- Whether focus follows the mouse pointer.

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.

myBorderWidth = 0

myWorkspaces = map show [1..9]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
      , ((modm,               xK_d     ), spawn "rofi -show run")


    -- launch gmrun
      -- , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
      , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
       , ((modm,               xK_c ), sendMessage NextLayout)

     -- Toggles noborder/full
       , ((modm,               xK_space ), sendMessage(Toggle NBFULL) >> sendMessage ToggleStruts)

    --  Reset the layouts on the current workspace to default
      , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
      , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
      , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
      , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
      , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
      , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
      , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
      , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
      , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
      , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
      , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
      , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
      , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
      ,((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
      , ((modm .|. shiftMask, xK_z     ), io (exitWith ExitSuccess))

    -- Restart xmonad
      , ((modm              , xK_z     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
    >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
      , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
      , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
    >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
    -- Layouts:

-- You can specify and transform your layouts by modifying these values
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.),
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.


myLayout = mkToggle  (single NBFULL) tiled where tiled   = Tall nmaster delta ratio
                                                 nmaster = 1
                                                 ratio   = 1/2
                                                 delta   = 3/100

------------------------------------------------------------------------
    -- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.

myManageHook = composeAll $
    [ className =? "MPlayer"        --> doFloat
      , className =? "Gimp"           --> doFloat
      , resource  =? "pavucontrol"    --> doFloat
      , resource  =? "desktop_window" --> doIgnore
      , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
    -- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--

myEventHook = mempty

------------------------------------------------------------------------
    -- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--

myStartupHook = return ()

------------------------------------------------------------------------
    -- Now run xmonad with all the defaults we set up

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ def { terminal           = "~/.cargo/bin/alacritty"
                 , modMask            = mod4Mask
                 , keys               = myKeys
                 , focusFollowsMouse  = myFocusFollowsMouse
                 , borderWidth        = myBorderWidth
                 , workspaces         = myWorkspaces
                 , mouseBindings      = myMouseBindings
                 , layoutHook         = avoidStruts myLayout
                 , manageHook         = manageDocks <+> myManageHook
                 , handleEventHook    = myEventHook <+> docksEventHook
                 , logHook            = dynamicLogWithPP $ xmobarPP { ppOutput  = hPutStrLn xmproc
                                                                    , ppTitle   = \x -> ""
                                                                    , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                                                                    , ppLayout  = \x -> ""
                                                                    , ppSep     = "  " }
                 , startupHook        = myStartupHook } `additionalKeysP` [ ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
                                                                          , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@  -2%")
                                                                          , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")

                                                                          , ("<XF86AudioPlay>", spawn "playerctl play-pause")
                                                                          , ("<XF86AudioPrev>", spawn "playerctl previous")
                                                                          , ("<XF86AudioNext>", spawn "playerctl next")

                                                                          , ("<XF86MonBrightnessUp>", spawn "lux -a 5%")
                                                                          , ("<XF86MonBrightnessDown>", spawn "lux -s 5%") ]


-- Color of current workspace in xmobar
xmobarCurrentWorkspaceColor = "#FF301B"
