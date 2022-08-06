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
#Include menu.ahk
#Include widget.ahk

Global Popup_time := 5000
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

PathToMainINI := A_ScriptDir . "\config.ini"

IniRead, Timer1, %PathToMainINI%, Config, Timer1, 180
IniRead, Timer2, %PathToMainINI%, Config, Timer2, 900
IniRead, Timer3, %PathToMainINI%, Config, Timer3, 1800
IniRead, Timer4, %PathToMainINI%, Config, Timer4, 3600
IniRead, Timer5, %PathToMainINI%, Config, Timer5, 7200
IniRead, Timer6, %PathToMainINI%, Config, Timer6, 14400

fnClock := Func("Clock")
SetTimer, %fnClock%, 1000

Return

Clock() {
    Static c_index
	c_index++
    CloseGUIs()

	If (Mod(c_index, Timer6)=0)
		Notifier("Yvraldis", "demon", "r")
	Else If (Mod(c_index, Timer5)=0)
		Notifier("Yvraldis", "demon", "l")
	Else If (Mod(c_index, Timer4)=0)
		Notifier("Yvraldis", "demon", "r")
	Else If (Mod(c_index, Timer3)=0)
		Notifier("Yvraldis", "shock", "l")
	Else If (Mod(c_index, Timer2)=0)
		Notifier("Yvraldis", "shock", "r")
	Else If (Mod(c_index, Timer1)=0)
		Notifier("Yvraldis", "shock", "l")
}
