; cl1pp3r_assets.ahk - UI theming and style definitions

global clTheme := {}
clTheme.bgColor := "0xFDF6E3"         ; Solarized light base
clTheme.noteColor := "0xFFFBCC"       ; Sticky note yellow
clTheme.textColor := "0x333333"       ; Dark readable text
clTheme.font := "Consolas"
clTheme.fontSize := 10
clTheme.titleFont := "Segoe UI Bold"
clTheme.titleSize := 12

ApplyTheme() {
  bg := clTheme.bgColor
  txt := clTheme.textColor
  titleFont := clTheme.titleFont
  titleSize := clTheme.titleSize
  font := clTheme.font
  fontSize := clTheme.fontSize

  Gui, Color, %bg%
  Gui, Font, s%titleSize% c%txt%, %titleFont%
  Gui, Add, Text,, ?? cl1pp3r: your sticky desk
  Gui, Font, s%fontSize% c%txt%, %font%
}