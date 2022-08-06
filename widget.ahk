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
; Notifier("Yvraldis", "demon", "r")
; Notifier("Yvraldis", "shock", "l")
;
;
Notifier(_Theme, _State, _align="r") {
	Static WinCount
	WinCount++

	PathToImage := A_ScriptDir . "\Themes\" . _Theme . "\imgsets\" . _State . ".png"
	PathToTXT := A_ScriptDir . "\Themes\" . _Theme . "\txtsets\" . _State . ".txt"
	PathToINI := A_ScriptDir . "\Themes\" . _Theme . "\configs\" . _State . ".ini"
	PIC_widget_y := A_ScreenHeight - PIC_h - Taskbar_h
	PIC_widget_x := (_align = "r") ? A_ScreenWidth - PIC_w - 40 : 40
	PIC_widget_w := PIC_w
	PIC_widget_h := PIC_h

	FileRead, TXT, %PathToTXT%
	If !FileExist(PathToINI) {
		IniWrite, 14, %PathToINI%, Config, TXT_size
		IniWrite, 00ff00, %PathToINI%, Config, TXT_color
		IniWrite, 180, %PathToINI%, Config, TXT_yPos
	}
	IniRead, TXT_size, %PathToINI%, Config, TXT_size, 14
	IniRead, TXT_color, %PathToINI%, Config, TXT_color, 00ff00
	IniRead, TXT_yPos, %PathToINI%, Config, TXT_yPos, 180

	TXT_color := "c" . TXT_color
	TXT_size := "s" . TXT_size
	TXT_widget_x := PIC_widget_x - 10
	TXT_widget_y := PIC_widget_y + TXT_yPos
	TXT_widget_w := PIC_w
	TXT_widget_h := PIC_h

	Gui, picwd%WinCount%: Color, 123456
	Gui, picwd%WinCount%: +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20 +HwndPICwdHwnd
	Gui, picwd%WinCount%: Add, Picture, x0 y0, %PathToImage%
	Gui, picwd%WinCount%: Show, x%PIC_widget_x% y%PIC_widget_y% w%PIC_widget_w% h%PIC_widget_h% NA, Power Reminder
	WinSet, TransColor, 123456, ahk_id %PICwdHwnd%

	Gui, txtwd%WinCount%: Color, 101020
	Gui, txtwd%WinCount%: +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20 +HwndTXTwdHwnd
	Gui, txtwd%WinCount%: Font, %TXT_color% %TXT_size%
	Gui, txtwd%WinCount%: Add, Text, w320 BackgroundTrans Center, %TXT%
	Gui, txtwd%WinCount%: Show, x%TXT_widget_x% y%TXT_widget_y% NA, Power Reminder
	WinSet, TransColor, 101020, ahk_id %TXTwdHwnd%

	WinArray.Push([A_TickCount, WinCount])
}

CloseGUIs() {
	Loop, % WinArray.length() {
		tNow := A_TickCount
		Saved := WinArray[A_Index][1]
		aSaved := Saved + Popup_time
		If aSaved && (aSaved <= tNow) {
			dif := tNow - Saved
			WinCount := WinArray[A_Index][2]
			Gui, txtwd%WinCount%: destroy
			Gui, picwd%WinCount%: destroy
            WinArray.RemoveAt(A_Index)
		}
	}
}


