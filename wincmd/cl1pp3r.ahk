#NoEnv
#SingleInstance Force
#Persistent
#Include %A_ScriptDir%\cl1pp3r_assets.ahk ; optional for future theming

global clipHistory := [], maxClips := 50
global noteWidth := 200, noteHeight := 100
global guiX := 50, guiY := 50

Menu, Tray, Add, Show Desk, ShowDesk
Menu, Tray, Add, Exit, ExitApp
Menu, Tray, Default, Show Desk
Menu, Tray, Click, 1

SetTimer, WatchClipboard, 500
CreateDesk()

return

WatchClipboard:
  ClipWait, 0.1
  if (Clipboard != "" && (clipHistory.Length() = 0 || Clipboard != clipHistory[1])) {
    clipHistory.InsertAt(1, Clipboard)
    if (clipHistory.Length() > maxClips)
      clipHistory.RemoveAt(maxClips + 1)
    RefreshDesk()
  }
return

CreateDesk() {
  Gui, +Resize +MinSize400x300 +AlwaysOnTop
  Gui, Add, Text,, 🧠 cl1pp3r: your sticky desk
  Gui, Add, Button, gMinimizeToTray, Minimize to Tray
  Gui, Add, Scrollbar, vScrollBar
  RefreshDesk()
  Gui, Show, x%guiX% y%guiY% w800 h600, cl1pp3r Desk
}

RefreshDesk() {
  Gui, Destroy
  Gui, +Resize +MinSize400x300 +AlwaysOnTop
  Gui, Add, Text,, 🧠 cl1pp3r: your sticky desk
  Gui, Add, Button, gMinimizeToTray, Minimize to Tray

  Loop % clipHistory.Length() {
    idx := A_Index
    txt := clipHistory[idx]
    Gui, Add, Edit, x% (20 + Mod(idx-1, 4)*210) y% (60 + Floor((idx-1)/4)*110) w%noteWidth% h%noteHeight% vNote%idx%, %txt%
  }

  Gui, Show, x%guiX% y%guiY% w800 h600, cl1pp3r Desk
}

MinimizeToTray:
  Gui, Hide
return

ShowDesk:
  Gui, Show
return

ExitApp:
  ExitApp