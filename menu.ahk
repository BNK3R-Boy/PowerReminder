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
Menu:
Global ThemeDropDownList := DDLbuilder(ReadThemes())
Global MemeDropDownList := DDLbuilder(ReadMemes())

Gui, menu: +LastFound +HwndMenuHwnd
Gui, menu: Font, s8 w600, Tahoma
Gui, menu: Add, Button, Hidden w0 h0 Default, Save
Gui, menu: Add, Tab, x0 y0 w%win_w% h%win_h% , Settings|Meme Timer||Info|

;--------------------------------------------------------------------- Timer Tab
Gui, menu: Tab, Meme Timer

column1 := 12
column2 := 72
column3 := 95
column4 := 117
column5 := 204
column6 := 292
column7 := 315
column8 := 331
column9 := 481
row1 := 29
row2 := 49
row3 := 69
row4 := 89
row5 := 109
row6 := 129
row7 := 149
row8 := 169

Gui, menu: Add, Text, x%column1% y%row2% w60 h20 , Timer 1
Gui, menu: Add, Text, x%column1% y%row3% w60 h20 , Timer 2
Gui, menu: Add, Text, x%column1% y%row4% w60 h20 , Timer 3
Gui, menu: Add, Text, x%column1% y%row5% w60 h20 , Timer 4
Gui, menu: Add, Text, x%column1% y%row6% w60 h20 , Timer 5
Gui, menu: Add, Text, x%column1% y%row7% w60 h20 , Timer 6

gbx := column2 - 1
gby := row2 - 1
Gui, menu: Add, Text, x%column2% y%row1% w60 h20 , On/Off
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_1 gWriteSelection x%column2% y%row2% w30 h20 ,
Gui, menu: Add, Radio, vRadio1_2 gWriteSelection x%column3% y%row2% w30 h20 ,

gby := row3 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_3 gWriteSelection x%column2% y%row3% w30 h20 ,
Gui, menu: Add, Radio, vRadio1_4 gWriteSelection x%column3% y%row3% w30 h20 ,

gby := row4 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_5 gWriteSelection x%column2% y%row4% w30 h20 ,
Gui, menu: Add, Radio, vRadio1_6 gWriteSelection x%column3% y%row4% w30 h20 ,

gby := row5 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_7 gWriteSelection x%column2% y%row5% w30 h20 ,
Gui, menu: Add, Radio, vRadio1_8 gWriteSelection x%column3% y%row5% w30 h20 ,

gby := row6 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_9 gWriteSelection x%column2% y%row6% w30 h20 ,
Gui, menu: Add, Radio, vRadio1_10 gWriteSelection x%column3% y%row6% w30 h20 ,

gby := row7 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_11 gWriteSelection x%column2% y%row7% w30 h20 ,
Gui, menu: Add, Radio, vRadio1_12 gWriteSelection x%column3% y%row7% w30 h20 ,

t := column4 + 5
Gui, menu: Font, s8 w600
Gui, menu: Add, Text, x%t% y%row1% w80 h20 , Theme
Gui, menu: Font, s7 w100
Gui, menu: Add, DropDownList, r5 vDDL1_1 gWriteSelection x%column4% y%row2% w80 h20 , %ThemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_2 gWriteSelection x%column4% y%row3% w80 h20 , %ThemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_3 gWriteSelection x%column4% y%row4% w80 h20 , %ThemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_4 gWriteSelection x%column4% y%row5% w80 h20 , %ThemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_5 gWriteSelection x%column4% y%row6% w80 h20 , %ThemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_6 gWriteSelection x%column4% y%row7% w80 h20 , %ThemeDropDownList%

t := column5 + 5
Gui, menu: Font, s8 w600
Gui, menu: Add, Text, x%t% y%row1% w80 h20 , Meme
Gui, menu: Font, s7 w100
Gui, menu: Add, DropDownList, r5 vDDL1_7 gWriteSelection x%column5% y%row2% w80 h20 , %MemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_8 gWriteSelection x%column5% y%row3% w80 h20 , %MemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_9 gWriteSelection x%column5% y%row4% w80 h20 , %MemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_10 gWriteSelection x%column5% y%row5% w80 h20 , %MemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_11 gWriteSelection x%column5% y%row6% w80 h20 , %MemeDropDownList%
Gui, menu: Add, DropDownList, r5 vDDL1_12 gWriteSelection x%column5% y%row7% w80 h20 , %MemeDropDownList%

gbx := column6 - 1
gby := row2 - 1
t := column6 + 5
Gui, menu: Font, s8 w600
Gui, menu: Add, Text, x%t% y%row1% w66 h20 , L / R
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_13 gWriteSelection x%column6% y%row2% w40 h20 ,
Gui, menu: Add, Radio, vRadio1_14 gWriteSelection x%column7% y%row2% w40 h20 ,

gby := row3 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_15 gWriteSelection x%column6% y%row3% w40 h20 ,
Gui, menu: Add, Radio, vRadio1_16 gWriteSelection x%column7% y%row3% w40 h20 ,

gby := row4 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_17 gWriteSelection x%column6% y%row4% w40 h20 ,
Gui, menu: Add, Radio, vRadio1_18 gWriteSelection x%column7% y%row4% w40 h20 ,

gby := row5 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_19 gWriteSelection x%column6% y%row5% w40 h20 ,
Gui, menu: Add, Radio, vRadio1_20 gWriteSelection x%column7% y%row5% w40 h20 ,

gby := row6 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_21 gWriteSelection x%column6% y%row6% w40 h20 ,
Gui, menu: Add, Radio, vRadio1_22 gWriteSelection x%column7% y%row6% w40 h20 ,

gby := row7 - 1
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio1_23 gWriteSelection x%column6% y%row7% w40 h20 ,
Gui, menu: Add, Radio, vRadio1_24 gWriteSelection x%column7% y%row7% w40 h20 ,

t := column8 + 10
w := 150
Gui, menu: Add, Text, x%t% y%row1% w115 h20 , Time
Gui, menu: Add, Slider, AltSubmit vSlider1_1 gWriteSelectionSlider range1-14400 x%column8% y%row2% w%w% h20 , 25
Gui, menu: Add, Slider, AltSubmit vSlider1_2 gWriteSelectionSlider range1-14400 x%column8% y%row3% w%w% h20 , 25
Gui, menu: Add, Slider, AltSubmit vSlider1_3 gWriteSelectionSlider range1-14400 x%column8% y%row4% w%w% h20 , 25
Gui, menu: Add, Slider, AltSubmit vSlider1_4 gWriteSelectionSlider range1-14400 x%column8% y%row5% w%w% h20 , 25
Gui, menu: Add, Slider, AltSubmit vSlider1_5 gWriteSelectionSlider range1-14400 x%column8% y%row6% w%w% h20 , 25
Gui, menu: Add, Slider, AltSubmit vSlider1_6 gWriteSelectionSlider range1-14400 x%column8% y%row7% w%w% h20 , 25

t := column9 + 26
Gui, menu: Font, s8 w600
Gui, menu: Add, Text, x%t% y%row1% w14 h20 , s.
Gui, menu: Font, s7 w100
Gui, menu: Add, Edit, r1 limit5 vEdit1_1 x%column9% y%row2% w40, 12345
Gui, menu: Add, Edit, r1 limit5 vEdit1_2 x%column9% y%row3% w40, 12345
Gui, menu: Add, Edit, r1 limit5 vEdit1_3 x%column9% y%row4% w40, 12345
Gui, menu: Add, Edit, r1 limit5 vEdit1_4 x%column9% y%row5% w40, 12345
Gui, menu: Add, Edit, r1 limit5 vEdit1_5 x%column9% y%row6% w40, 12345
Gui, menu: Add, Edit, r1 limit5 vEdit1_6 x%column9% y%row7% w40, 12345


;------------------------------------------------------------------ Settings Tab
Gui, menu: Tab, Settings

column1 := 12
column2 := 232
column3 := 255
column4 := 331
column5 := 481


gbx := column2 - 1
gby := row2 - 1
Gui, menu: Font, s8 w600
Gui, menu: Add, Text, x%column2% y%row1% w60 h20 , On/Off
Gui, menu: Add, Text, x%column1% y%row2% w180 h20 , Energy Reminder
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio2_1 gWriteSelection x%column2% y%row2% w30 h20 ,
Gui, menu: Add, Radio, vRadio2_2 gWriteSelection x%column3% y%row2% w30 h20 ,

gby := row3 - 1
Gui, menu: Font, s8 w600
Gui, menu: Add, Text, x%column1% y%row3% w180 h20 , Energy Reminder Pop-Ups
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio2_3 gWriteSelection x%column2% y%row3% w30 h20 ,
Gui, menu: Add, Radio, vRadio2_4 gWriteSelection x%column3% y%row3% w30 h20 ,

gby := row4 - 1
Gui, menu: Add, Text, x%column2% y%row1% w60 h20 , On/Off
Gui, menu: Add, Text, x%column1% y%row4% w180 h20 , Meme Pop-Ups
Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h22,
Gui, menu: Add, Radio, vRadio2_5 gWriteSelection x%column2% y%row4% w30 h20 ,
Gui, menu: Add, Radio, vRadio2_6 gWriteSelection x%column3% y%row4% w30 h20 ,

t := column4 + 10
w := 150
Gui, menu: Add, Text, x%t% y%row1% w115 h20 , Time
Gui, menu: Add, Slider, AltSubmit vSlider2_1 gWriteSelectionSlider range1-14400 x%column4% y%row3% w%w% h20 , 25

t := column5 + 26
Gui, menu: Font, s8 w600
Gui, menu: Add, Text, x%t% y%row1% w14 h20 , s.
Gui, menu: Font, s7 w100
Gui, menu: Add, Edit, r1 limit5 vEdit2_1 x%column5% y%row3% w40, 12345


;------------------------------------------------------------------ Settings Tab
Gui, menu: Tab, Info
t := column1
w := win_w - 15
h := win_h - 40
f := A_ScriptDir . "\Info.pr"
FileRead, i, %f%
Gui, menu: Font, s8 w0, Courier New
Gui, menu: Add, Text, gOpenGithub x%t% y%row1% w%w% h%h% , %i%
Gui, menu: Font, s7 w100

Loop, 24
	TrimRadiobox("Radio1_" . A_Index)
Loop, 6
	TrimRadiobox("Radio2_" . A_Index)

Load_CFG_Radios()
Load_CFG_DDL()
Load_CFG_Edit()

Gui, menu: Show, x622 y349 w%win_w% h%win_h%, %AppTitle%
Return

DDLbuilder(arr) {
	DropDownList := ""
	Loop, % arr.length()
		DropDownList .= arr[A_Index] . "|"
	Return DropDownList
}

GetSlotIdFromArray(arr, k) {
	loops := arr.length()
	Loop, %loops%
		If (arr[A_Index] = k)
			Return A_Index
	Return 1
}

Load_CFG_DDL() {
	Loop, 6 { ; ------------------ Theme
        SelectDDLitem("DDL1_" . A_Index, ReadThemes(), ReadIni("theme", "Timer" . A_Index))
	}
	Loop, 6 { ; ------------------ Meme
		SelectDDLitemlist("DDL1_" . (A_Index + 6), ReadMemes(ReadIni("theme", "Timer" . A_Index)))
		SelectDDLitem("DDL1_" . (A_Index + 6), ReadMemes(), ReadIni("meme", "Timer" . A_Index))
	}
}

Load_CFG_Edit() {
	Loop, 6 { ; ------------------ Theme
		k := "Edit1_" . A_Index
		t := ReadIni("time", "Timer" . A_Index)
        GuiControl, menu:, %k%, %t%
        k := "Slider1_" . A_Index
        GuiControl, menu:, %k%, %t%
	}

	t := ReadIni("time", "Settings")
    GuiControl, menu:, Edit2_1, %t%
    GuiControl, menu:, Slider2_1, %t%

}

Load_CFG_Radios() {
	L_Index := 1
	Loop, 6 {
		k := "Radio1_" . ((ReadIni("onoff", "Timer" . A_Index)) ? L_Index : (L_Index + 1))
		GuiControl, menu:, %k%, 1
		k := "Radio1_" . ((ReadIni("align", "Timer" . A_Index)="l") ? (L_Index + 12) : (L_Index + 13))
		GuiControl, menu:, %k%, 1
		L_Index += 2
	}

	k := "Radio2_" . ((ReadIni("onoff", "Energy Reminder")) ? 1 : 2)
	GuiControl, menu:, %k%, 1
	k := "Radio2_" . ((ReadIni("EnergyReminderPopUps", "Settings")) ? 3 : 4)
	GuiControl, menu:, %k%, 1
	k := "Radio2_" . ((ReadIni("MemePopUps", "Settings")) ? 5 : 6)
	GuiControl, menu:, %k%, 1
}

ReadIni(k, s="Config", d="") {
	If FileExist(PathToMainINI)
		IniRead, v, %PathToMainINI%, %s%, %k%, %d%
	Else
		IniWrite, %d%, %PathToMainINI%, %s%, %k%
	Return %v%
}

ReadThemes() {
	arr := []
	tf := A_ScriptDir . "\Themes\*.*"
	Loop Files, %tf%, D
    	arr.Push(A_LoopFileName)
	Return arr
}

ReadMemes(theme="Yvraldis") {
	arr := []
	mf := A_ScriptDir . "\Themes\" . theme . "\configs\*.*"
	Loop Files, %mf%, F
	{
        SplitPath, A_LoopFileName , ,,,f
		arr.Push(f)
	}
	If !arr.length()
		arr := ReadMemes()
	Return arr
}

SaveIni(k, v, s="Config") {
    If FileExist(PathToMainINI)
	{
	    IniRead, check_v, %PathToMainINI%, %s%, %k%, 0
		If (check_v != v) 
			IniWrite, %v%, %PathToMainINI%, %s%, %k%
	} 
}

SelectDDLitemlist(key, ddlarray) {
	GuiControl, menu:, %key%, |
	GuiControl, menu:, %key%, % DDLbuilder(ddlarray)
}

SelectDDLitem(key, ddlarray, itemName) {
	GuiControl, menu: Choose, %key%, % GetSlotIdFromArray(ddlarray, itemName)
    GuiControlGet, itemName, menu:, %key%
	Return itemName
}

TrimRadiobox(Radiobox) {
	GuiControlGet, r, menu: Pos, %Radiobox%
	GuiControl, menu: Move, %Radiobox%, w%rH%
}

WriteSelectionSlider:
	Loop, 6 {
		e := "Edit1_" . A_Index
		s := "Slider1_" . A_Index
		sv := %s%
		(sv > 14400) ? sv := 14400
		(sv < 15) ? sv := 15
		GuiControl, menu:, %e%, %sv%
		GuiControl, menu:, %s%, %sv%
	}
	(Slider2_1 > 14400) ? Slider2_1 := 14400
	(Slider2_1 < 15) ? Slider2_1 := 15
	GuiControl, menu:, Edit2_1, %Slider2_1%
	GuiControl, menu:, Slider2_1, %Slider2_1%
	GoTo, WriteSelection
Return

menuButtonSave:
	Gui, menu: Submit, NoHide
	Loop, 6 {
		s := "Slider1_" . A_Index
		e := "Edit1_" . A_Index
		ev := %e%
		(ev > 14400) ? ev := 14400
		(ev < 15) ? ev := 15
		GuiControl, menu:, %s%, %ev%
		GuiControl, menu:, %e%, %ev%
	}

	(Edit2_1 > 14400) ? Edit2_1 := 14400
	(Edit2_1 < 15) ? Edit2_1 := 15
	GuiControl, menu:, Slider2_1, %Edit2_1%
	GuiControl, menu:, Edit2_1, %Edit2_1%
	GoTo, WriteSelection
WriteSelection:
	Gui, menu: Submit, NoHide
	L_Index := 1
	Loop, 6 {
		r := "Radio1_" . L_Index
		r := %r%
		th := "DDL1_" . A_Index
		th := %th%
		s := "DDL1_" . A_Index + 6
		s := %s%
		a := "Radio1_" . L_Index + 12
		a := (%a% = 1) ? "l" : "r"
		t := "Edit1_" . A_Index
		t := %t%

		SelectDDLitemlist("DDL1_" . (A_Index + 6), ReadMemes(th))
		s:= SelectDDLitem("DDL1_" . (A_Index + 6), ReadMemes(th), s)

		SaveIni("onoff", r, "Timer" . A_Index)
		SaveIni("theme", th, "Timer" . A_Index)
		SaveIni("meme", s, "Timer" . A_Index)
		SaveIni("align", a, "Timer" . A_Index)
		SaveIni("time", t, "Timer" . A_Index)

		L_Index += 2
	}

	SaveIni("onoff", Radio2_1, "Settings")
	SaveIni("time", Edit2_1, "Settings")
	SaveIni("MemePopUps", Radio2_5, "Settings")
	SaveIni("EnergyReminderPopUps", Radio2_3, "Settings")
	If (!ReadIni("onoff", "Settings")) || (!ReadIni("MemePopUps", "Settings")) {
        SetTimer, %fnClock%, off
        ClosePopUpGUIs("kill")
	} Else
		SetTimer, %fnClock%, 1000

	If (!ReadIni("EnergyReminderPopUps", "Settings")) {
        SetTimer, %fnEnRi%, off
        ClosePopUpGUIs("kill")
	} Else {
		t := Edit2_1 * 1000
		SetTimer, %fnEnRi%, %t%
	}
Return

OpenGithub:
	Run https://github.com/BNK3R-Boy/PowerReminder
Return

menuGuiClose:
	Gui, menu: Destroy
Return

Reload:
	Reload
Return

Exit:
	ExitApp
Return