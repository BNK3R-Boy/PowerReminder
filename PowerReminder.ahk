; Power Reminder - Yvraldis Edition - writte by
;
;
;      ██████╗ ███╗   ██╗██╗  ██╗██████╗ ██████╗ ██████╗  ██████╗ ██╗   ██╗
;      ██╔══██╗████╗  ██║██║ ██╔╝╚════██╗██╔══██╗██╔══██╗██╔═══██╗╚██╗ ██╔╝
;      ██████╔╝██╔██╗ ██║█████╔╝  █████╔╝██████╔╝██████╔╝██║   ██║ ╚████╔╝
;      ██╔══██╗██║╚██╗██║██╔═██╗  ╚═══██╗██╔══██╗██╔══██╗██║   ██║  ╚██╔╝
;      ██████╔╝██║ ╚████║██║  ██╗██████╔╝██║  ██║██████╔╝╚██████╔╝   ██║
;      ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝    ╚═╝
;
;
;                                                                    on 06/08/2022 13:23
;
;                    https://github.com/BNK3R-Boy/PowerReminder
;
;
;
;
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent

Global Popup_time := 3000
Global Taskbar_h := 30
Global PIC_w := 300
Global PIC_h := 300
Global WinArray := []
Global Timer1 := ini
Global Timer2 := ini
Global Timer3 := ini
Global Timer4 := ini
Global Timer5 := ini
Global Timer6 := ini

Global PathToMainINI := A_ScriptDir . "\config.ini"

AppTitle := "Power Reminder - Yvraldis Edition"
win_w := 533
win_h := 180
Global ICO := A_ScriptDir . "\Icon.ico"

Global DDLArray1 := ["Random","Yvraldis"]
Global DDLArray2 := ["Shock","Demon"]

Menu, Tray, NoStandard
Menu, Tray, Tip, %AppTitle%
Menu, Tray, Add, Menu, Menu
Menu, Tray, Add, Reload, Reload
Menu, Tray, Add,
Menu, Tray, Add, Exit, Exit
Menu, Tray, Default, Menu
Menu, Tray, Icon, %ICO%


fnClock := Func("Clock")
If (ReadIni("onoff", "Energy Reminder"))
	SetTimer, %fnClock%, 1000

fnEnRi := Func("EnRi")
If (ReadIni("EnergyReminderPopUps", "Settings")) {
	t := ReadIni("time", "Settings") * 1000
	SetTimer, %fnEnRi%, %t%
}

#Include menu.ahk
#Include widget.ahk
Return

Clock() {
    Memes()
    ClosePopUpGUIs()
}

Memes() {
    Static c_index
	c_index++
    If (ReadIni("MemePopUps", "Settings")) {
		Loop, 6 {
			k := "Timer" . (7 - A_Index)
			If (Mod(c_index, ReadIni("time", k))=0) && ReadIni("onoff", k) {
				Notifier(ReadIni("theme", k), ReadIni("status", k), ReadIni("align", k))
				Break
			}
		}
	}
}

EnRi() {
    If (ReadIni("EnergyReminderPopUps", "Settings")) {
    	Notifier("Yvraldis", "demon", "r")
	}
}