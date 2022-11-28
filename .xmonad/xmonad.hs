import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.SpawnOnce

mainFont :: String
mainFont = "xft:DroidSansMono Nerd Font:size=10:antialias=true:autohint=true"

startHook :: X ()
startHook = do
  spawnOnce "xrdb -load -nocpp $HOME/.Xresources"

  -- docked:
  spawnOnce "xrandr --output DP-3 --off --output DP-0 --primary --mode 5120x1440"
  spawnOnce "xrdb -merge -nocpp $HOME/.config/xsessions/dwm/Xresources-docked-overrides"
  spawnOnce "feh --no-fehbg --bg-fill $HOME/media/pictures/wallpapers/ultrawide"

mainConfig :: XConfig (Choose Tall (Choose (Mirror Tall) Full))
mainConfig = def {
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
