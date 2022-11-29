import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.LayoutModifier
import XMonad.Util.SpawnOnce

mainFont :: String
mainFont = "xft:DroidSansMono Nerd Font:size=10:antialias=true:autohint=true"

startHook :: X ()
startHook = do
  spawnOnce "systemctl --user import-environment"
  spawnOnce "systemctl --user start xsession.target"

mainConfig :: XConfig (XMonad.Layout.LayoutModifier.ModifiedLayout XMonad.Hooks.ManageDocks.AvoidStruts (Choose Tall (Choose (Mirror Tall) Full)))
mainConfig = desktopConfig {
  borderWidth        = 2,
  focusFollowsMouse  = False,
  focusedBorderColor = "#f0c674",
  modMask            = mod4Mask,
  normalBorderColor  = "#282a2e",
  startupHook        = startHook,
  terminal           = "urxvt"
}


main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey mainConfig

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
