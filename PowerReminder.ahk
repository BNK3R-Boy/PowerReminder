#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#InstallKeybdHook
#MaxThreadsPerHotkey 1
#MaxThreadsBuffer 1

SetKeyDelay, 50, 5
SetBatchLines, -1
FileEncoding, UTF-8
Global AppTitle := "Power Reminder - Yvraldis Edition"
Global AppVersion := "0.1"
Global AppToolTip := AppTitle
Global GBBa := ["Start", "Select", "A", "B", "Up", "Down", "Left", "Right", "Spare"]
Global GBBai := []
Global TF := A_Temp . "\PowerReminder\"
Global ICO := TF . "PowerReminder.ico"
Global InfoText
InfoText =
(

   Power Reminder - Yvraldis Edition                         writte by
                                          
   ██████╗ ███╗   ██╗██╗  ██╗██████╗ ██████╗ ██████╗  ██████╗ ██╗   ██╗
   ██╔══██╗████╗  ██║██║ ██╔╝╚════██╗██╔══██╗██╔══██╗██╔═══██╗╚██╗ ██╔╝
   ██████╔╝██╔██╗ ██║█████╔╝  █████╔╝██████╔╝██████╔╝██║   ██║ ╚████╔╝
   ██╔══██╗██║╚██╗██║██╔═██╗  ╚═══██╗██╔══██╗██╔══██╗██║   ██║  ╚██╔╝
   ██████╔╝██║ ╚████║██║  ██╗██████╔╝██║  ██║██████╔╝╚██████╔╝   ██║
   ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝    ╚═╝

   on August 2👽22                                                 v%AppVersion%
)
Global LogModul := 0
Global PathToMainINI := TF . "\config.ini"
Global PIC_h := 300
Global PIC_w := 300
Global Popup_time
Global Taskbar_h := 30
Global URL := "https://github.com/BNK3R-Boy/PowerReminder"
Global WinArray := []
Global win_h := 180
Global win_w := 533
Global WinHistoryArray := []
Global Slider1_1_TT, Slider1_2_TT, Slider1_3_TT, Slider1_4_TT, Slider1_5_TT, Slider1_6_TT
Global Slider2_1_TT, Slider2_2_TT
Global SplashPIC_widget_h := 200
Global SplashPIC_widget_w := 600
Global PathToSplashImage := TF . "splash.png"
Global TwitchTitle := "Twitch: Disconnected"
Global TwitchLink
Global YouTubeTitle := "YouTube: Disconnected"
Global YouTubeLink
Global TwitterTitle := "Twitter: Disconnected"
Global TwitterLink
Global InstagramTitle := "Instagram: Disconnected"
Global InstagramLink
Global NOTIFIERLOG := "Notifierlog.txt"
If !FileExist(TF)
	FileCreateDir, %TF%
If !FileExist(ICO)
	FileInstall, PowerReminder.ico, %ICO%, 1
If !FileExist(PathToSplashImage)
	FileInstall, splash.png, %PathToSplashImage%, 1
CreateIniFile()
Popup_time := ReadIni("PopUpTime", "Settings", 3)

SplashScreen()
Menu, Tray, NoStandard
Menu, Tray, Icon, %ICO%

Menu, Tray, Tip, %AppTooltip%
Menu, Tray, Add, %TwitchTitle%, OpenTwitchStream
Menu, Tray, Add, %YouTubeTitle%, OpenYouTubeLink
Menu, Tray, Add, %InstagramTitle%, OpenInstagramLink
Menu, Tray, Add, %TwitterTitle%, OpenTwitterLink
Menu, webportals, Add, Twitch, OpenTwitchStream
Menu, webportals, Add, YouTube, OpenYouTubeLink
Menu, webportals, Add, Instagram, OpenInstagram
Menu, webportals, Add, Twitter, OpenTwitter
Menu, Tray, Add, Web portals, :webportals
Menu, Tray, Add, Etsy Store, OpenEtsy
Menu, Tray, Add,
Menu, Tray, Add, Menu, Menu
Menu, Tray, Add, Unstuck Pop-Ups, CloseAllPopUpGUIs
Menu, Tray, Add,
Menu, Tray, Add, Reload, Reload
Menu, Tray, Add, Exit, Exit
Menu, Tray, Default, Menu

Hotkey, Joy1 , GameboyButton
Hotkey, Joy2 , GameboyButton
Hotkey, Joy7 , GameboyButton
Hotkey, Joy8 , GameboyButton

fnClock := Func("Clock")
Global fnEnRi := Func("EnRi")

If (ReadIni("onoff", "Energy Reminder"))
	SetTimer, %fnClock%, 50

If (ReadIni("EnergyReminderPopUps", "Settings")) {
	t := ReadIni("time", "Settings") * 1000
	SetTimer, %fnEnRi%, %t%
}

RefreshMenu(1)
Load_GBB()

fnRefreshMenu := Func("RefreshMenu")
SetTimer, %fnRefreshMenu%, 30000

OnError("errRe")
OnMessage(0x200, "WM_MOUSEMOVE")

GetWebData("Twitch", "https://www.twitch.tv/yvraldis")
GetWebData("YouTube", "https://rss.app/feeds/lUebcex3LEssYKpk.xml")
GetWebData("Twitter", "https://rss.app/feeds/RlRJtcDm23osS3Dp.xml")
GetWebData("Instagram", "https://rss.app/feeds/TFWPloYEDai0dx6r.xml")

Gui, Splash: destroy
Global Loaded := 1
Return

ClearOldTimesFromWinArray(age) {
	Loop, % WinArray.length() {
		tNow := A_TickCount
		Saved := WinArray[A_Index][1]
		WinCount := WinArray[A_Index][2]
		aSaved := Saved + Popup_time
		dif := tNow - Saved
		If (dif >= age) {
			Gui, txtwd%WinCount%: destroy
			Gui, picwd%WinCount%: destroy
			WinArray.RemoveAt(A_Index)
            LogEvent("Notifier: " . WinCount . " - Closed by history", NOTIFIERLOG)
		}
	}
}

Clock() {
    IdleModule()
    Memes()
    ClosePopUpGUIs()
    ClearOldTimesFromWinArray(Popup_time * 10)
    GameBoy()
}

CloseAllPopUpGUIs() {
	Loop, % WinHistoryArray.length() {
		WinCount := WinHistoryArray[A_Index]
		Gui, txtwd%WinCount%: destroy
		Gui, picwd%WinCount%: destroy
        LogEvent("Notifier: " . WinCount . " - Closed by close all", NOTIFIERLOG)
	}
}

ClosePopUpGUIs(k="") {
	Loop, % WinArray.length() {
		tNow := A_TickCount
		If (k="kill")
			tNow *= 9999999999
		Saved := WinArray[A_Index][1]
		WinCount := WinArray[A_Index][2]
		dif := Round(tNow - Saved, 0)
		If Saved && WinCount && (dif >= Popup_time) {
			Gui, txtwd%WinCount%: destroy
			Gui, picwd%WinCount%: destroy
			WinArray.RemoveAt(A_Index)
            LogEvent("Notifier: " . WinCount . " - Closed by countdown", NOTIFIERLOG)
		}
	}
}

CountMemes(th) {
    tf := A_ScriptDir . "\Themes\" . th . "\configs\*.*"
	Loop Files, %tf%, F
		count++
	Return count
}

CountThemes() {
    tf := A_ScriptDir . "\Themes\*.*"
	Loop Files, %tf%, D
		count++
	Return count
}

CreateIniFile() {
	If !FileExist(PathToMainINI) {
		SaveIni("onoff", 1)
	    SaveIni("time", 4200)
	    SaveIni("MemePopUps", 1)
	    SaveIni("EnergyReminderPopUps", 0)
	    SaveIni("PopUpTime", 2500)
	    SaveIni("Idle", 0)

	    SaveIni("onoff", 1, "Timer1")
	    SaveIni("theme", "Yvraldis", "Timer1")
	    SaveIni("meme", "demon", "Timer1")
	    SaveIni("align", "l", "Timer1")
	    SaveIni("time", 600, "Timer1")

	    SaveIni("onoff", 1, "Timer2")
	    SaveIni("theme", "Yvraldis", "Timer2")
	    SaveIni("meme", "shock", "Timer2")
	    SaveIni("align", "r", "Timer2")
	    SaveIni("time", 900, "Timer2")

	    SaveIni("onoff", 1, "Timer3")
	    SaveIni("theme", "Yvraldis", "Timer3")
	    SaveIni("meme", "demon", "Timer3")
	    SaveIni("align", "l", "Timer3")
	    SaveIni("time", 1800, "Timer3")

	    SaveIni("onoff", 1, "Timer4")
	    SaveIni("theme", "Yvraldis", "Timer4")
	    SaveIni("meme", "shock", "Timer4")
	    SaveIni("align", "r", "Timer4")
	    SaveIni("time", 3600, "Timer4")

	    SaveIni("onoff", 1, "Timer5")
	    SaveIni("theme", "Yvraldis", "Timer5")
	    SaveIni("meme", "demon", "Timer5")
	    SaveIni("align", "l", "Timer5")
	    SaveIni("time", 7200, "Timer5")

	    SaveIni("onoff", 1, "Timer6")
	    SaveIni("theme", "Yvraldis", "Timer6")
	    SaveIni("meme", "shock", "Timer6")
	    SaveIni("align", "r", "Timer6")
	    SaveIni("time", 14400, "Timer6")
	}
}

DDLbuilder(arr) {
	DropDownList := ""
	Loop, % arr.length()
		DropDownList .= arr[A_Index] . "|"
	Return DropDownList
}

EnRi() {
    If (ReadIni("EnergyReminderPopUps", "Settings")) {
		theme := selectRNDtheme()
		meme := selectRNDmeme(theme)
		If !ReadIni("Idle", "Settings")
			Notifier(theme, meme, (rnd(1,2)=1) ? "l" : "r")
		Else
			If (A_TimeIdle >= 3000) {
                Notifier(theme, meme, (rnd(1,2)=1) ? "l" : "r")
			}
	}
}

errRe(exception) {
    FileAppend % "Error on line " exception.Line ": " exception.Message "`n"
        , errorlog.txt
    SoundBeep, 1200, 5000
    Reload
}

Fill_Edit(box, k, s) {
	t := ReadIni(k, s)
    StringReplace, i, box, Edit4_
    GBBai[i] := t
    GuiControl, menu:, %box%, %t%
}

GameBoy(b="") {
    Critical
	Static a
    fnWatchDPad := Func("WatchDPad")
	GameBoyMode := ReadIni("GamBoyMode", "Settings", 0)
	(!GameBoyMode && b) ? a := 1
	If (GameBoyMode && !a) {
		SetTimer, %fnWatchDPad%, 150
		Hotkey, Joy1 , On
		Hotkey, Joy2 , On
		Hotkey, Joy7 , On
		Hotkey, Joy8 , On
		a := 1
	}
	If (!GameBoyMode && a) {
		SetTimer, %fnWatchDPad%, OFF
		Hotkey, Joy1 , OFF
		Hotkey, Joy2 , OFF
		Hotkey, Joy7 , OFF
		Hotkey, Joy8 , OFF
		a := 0
	}
}

GBM(k) {
    Critical
	SendEvent, %k%{Enter}
	Sleep, 1000
	e := GBBai[9]
	SendEvent, %e%{Enter}
}

GetRSSData(turl) {
	If IsOnline() {
		Page := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		Page.Open("GET", turl, true)
		Page.Send()
		Page.WaitForResponse()
		XML := ComObjCreate("MSXML2.DOMDocument.6.0")
		XML.Async := false
		XML.LoadXML(Page.ResponseText)
		XMLNode := XML.SelectSingleNode("//channel/item/title")
		wt := XMLNode.Text
		XMLNode := XML.SelectSingleNode("//channel/item/link")
		lk := XMLNode.Text
		Return [wt, lk]
	} Else
		Return ["Disconnected",""]
}

GetSlotIdFromArray(arr, k) {
	loops := arr.length()
	Loop, %loops%
		If (arr[A_Index] = k)
			Return A_Index
	Return 1
}

GetWebData(platform, url) {
	ot := %platform%Title
	l := %platform%Link

	If (platform!="Twitch") {
	    RSSdata:= GetRSSData(url)
	    sarray := StrSplit(RSSdata[1]," ")
	    If (RSSdata[1]!="Disconnected") {
			str := ""
			Loop, 10
				str .= sarray[A_Index] . " "
			%platform%Title := platform . ": " . trim(str) . "..."
		} Else
			%platform%Title := platform . ": " . RSSdata[1]
	    %platform%Link := RSSdata[2]
		nt := %platform%Title
        Menu, Tray, Rename, %ot% , %nt%
	} Else {
		If IsOnline() {
			Page := ComObjCreate("WinHttp.WinHttpRequest.5.1")
			Page.Open("GET", url, true)
			Page.Send()
			Page.WaitForResponse()
			Page := Page.ResponseText

		    beforeString1 = description`" content=`"
			afterString1 = `"/><
			SearchStr := "s)\Q" . beforeString1 . "\E(.*?)\Q" . afterString1 . "\E"

			foundAtPos1 := RegExMatch(Page, SearchStr, res)
			a := StrSplit(res1 , "|")
			%platform%Title := (a[1]) ? "Twitch: " . a[1] : "Twitch: Stream title temporarily not available"
		  	AppTooltip := AppTitle . "`n" . a[1]
			Menu, Tray, Tip, %AppTooltip%
		} Else
			%platform%Title := "Twitch: Disconnected"
		nt := %platform%Title
        Menu, Tray, Rename, %ot% , %nt%
	}
}

IdleModule() {
    If ReadIni("Idle", "Settings") && (A_TimeIdle >= 1) && (A_TimeIdle <= 50)
		SetTimer, %fnEnRi%, %t%
}

IsOnline() {
	RunWait, %ComSpec% /c ping -n 1 1.1.1.1 ,, Hide UseErrorLevel
	Return !ErrorLevel
}

Load_CFG_DDL() {
	DTheme := "Yvraldis"
	Loop, 6 { ; ------------------ Theme
        SelectDDLitem("DDL1_" . A_Index, ReadThemes(), ReadIni("theme", "Timer" . A_Index, DTheme))
	}
	Loop, 6 { ; ------------------ Meme
		SelectDDLitemlist("DDL1_" . (A_Index + 6), ReadMemes(ReadIni("theme", "Timer" . A_Index, DTheme)))
		SelectDDLitem("DDL1_" . (A_Index + 6), ReadMemes(), ReadIni("meme", "Timer" . A_Index, ""))
	}
}

Load_CFG_Edit() {
	s := "GameBoy"
	Loop, % GBBa.length() {
		Fill_Edit("Edit4_" . A_index, GBBa[A_Index], s)
	}

	DTarray =: ["600","900","1800","3600","7200","14400"]
	Loop, 6 { ; ------------------ Theme
		k := "Edit1_" . A_Index
		t := ReadIni("time", "Timer" . A_Index, DTarray[A_Index])
        GuiControl, menu:, %k%, %t%
        k := "Slider1_" . A_Index
        GuiControl, menu:, %k%, %t%
		%k%_TT := t
	}
	t := ReadIni("time", "Settings", 10800)
    GuiControl, menu:, Edit2_1, %t%
    GuiControl, menu:, Slider2_1, %t%
	Slider2_1_TT := t
	t := ReadIni("popuptime", "Settings", 5)
    GuiControl, menu:, Edit2_2, %t%
    GuiControl, menu:, Slider2_2, %t%
	Slider2_2_TT := t

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
	k := "Radio2_" . ((ReadIni("EnergyReminderPopUps", "Settings", 0)) ? 3 : 4)
	GuiControl, menu:, %k%, 1
	k := "Radio2_" . ((ReadIni("Idle", "Settings", 0)) ? 5 : 6)
	GuiControl, menu:, %k%, 1
	k := "Radio2_" . ((ReadIni("MemePopUps", "Settings", 0)) ? 7 : 8)
	GuiControl, menu:, %k%, 1
	k := "Radio2_" . ((ReadIni("GamBoyMode", "Settings", 0)) ? 9 : 10)
	GuiControl, menu:, %k%, 1
}

Load_GBB() {
    Loop, 9
    	GBBai[A_Index] := ReadIni(GBBa[A_Index], "GameBoy")
	GameBoy(1)
}

LogEvent(txt, file) {
	If LogModul {
        FormatTime, timestamp, , [yyyyMMddHHmmss]
		txt := timestamp . " " . txt . "`n"
		FileAppend, %txt%, %file%
	}
}

Memes() {
    If (ReadIni("MemePopUps", "Settings")) {
		Loop, 6 {
			k := "Timer" . (7 - A_Index)
			If (Mod(A_Now, ReadIni("time", k))=0) && ReadIni("onoff", k) {
				Notifier(ReadIni("theme", k), ReadIni("status", k), ReadIni("align", k))
				Break
			}
		}
	}
}

Notifier(theme, meme, align="r") {
	Static WinCount
	Try {
		WinCount++
		PathToImage := A_ScriptDir . "\Themes\" . theme . "\imgsets\" . meme . ".png"
		PathToTXT := A_ScriptDir . "\Themes\" . theme . "\txtsets\" . meme . ".txt"
		PathToINI := A_ScriptDir . "\Themes\" . theme . "\configs\" . meme . ".ini"

		FileRead, TXT, %PathToTXT%

		IniRead, TXT_size, %PathToINI%, Config, TXT_size, 14
		IniRead, TXT_color, %PathToINI%, Config, TXT_color, 00ff00
		IniRead, TXT_yPos, %PathToINI%, Config, TXT_yPos, 180

		PIC_widget_y := A_ScreenHeight - PIC_h - Taskbar_h
		PIC_widget_x := (align = "r") ? A_ScreenWidth - PIC_w - 40 : 40
		PIC_widget_w := PIC_w
		PIC_widget_h := PIC_h


		TXT_color := "c" . TXT_color
		TXT_size := "s" . TXT_size
		TXT_widget_x := PIC_widget_x - 10
		TXT_widget_y := PIC_widget_y + TXT_yPos
		TXT_widget_w := PIC_w
		TXT_widget_h := PIC_h

		c1 := WinArray.length()
		WinArray.Push([A_TickCount, WinCount])
		WinHistoryArray.Push(WinCount)
		c2 := WinArray.length()
		If (c1 == c2) {
			Msgbox, error in WinArray`nc1: %c1% c2: %c2%
			Return
		}
		If (!A_TickCount) || (!WinCount) {
			Msgbox, error in WinArray`nA_TickCount: %A_TickCount% WinCount: %WinCount%
			Return
		}

		Gui, picwd%WinCount%: Color, 123456
		Gui, picwd%WinCount%: +LastFound +AlwaysOnTop -Caption +ToolWindow +HwndPICwdHwnd
		Gui, picwd%WinCount%: Add, Picture, x0 y0, %PathToImage%
		Gui, picwd%WinCount%: Show, x%PIC_widget_x% y%PIC_widget_y% w%PIC_widget_w% h%PIC_widget_h% NA, Power Reminder Widget | %WinCount%
		WinSet, TransColor, 123456, ahk_id %PICwdHwnd%

		Gui, txtwd%WinCount%: Color, 101020
		Gui, txtwd%WinCount%: +LastFound +AlwaysOnTop -Caption +ToolWindow +HwndTXTwdHwnd
		Gui, txtwd%WinCount%: Font, %TXT_color% %TXT_size%
		Gui, txtwd%WinCount%: Add, Text, w320 BackgroundTrans Center, %TXT%
		Gui, txtwd%WinCount%: Show, x%TXT_widget_x% y%TXT_widget_y% NA, Power Reminder Widget | %WinCount%
		WinSet, TransColor, 101020, ahk_id %TXTwdHwnd%
		; msgbox, PathToINI %PathToINI%`ntheme %theme%`nmeme %meme%`nalign %align%`nTXT_size %TXT_size%`nTXT_color %TXT_color%`nTXT_yPos %TXT_yPos%
		; SoundBeep, 1200, 250
        LogEvent("Notifier: " . WinCount . " - PathToINI: " . PathToINI . " - Theme: " . theme . " - Meme: " . meme . " - Align: " . align . " - TXT_size: " . TXT_size . " - TXT_color: " . TXT_color . " - TXT_yPos: "  . TXT_yPos, NOTIFIERLOG)
	}
	; Catch
		; LogEvent("Notifier: Error " . WinCount, NOTIFIERLOG)
}

OpenEtsy() {
	turl := "https://www.etsy.com/de/shop/Yvraldis"
	Run, %turl%
}

OpenInstagram() {
	turl := "https://www.instagram.com/yvraldis"
	Run, %turl%
}

OpenTwitchStream() {
	turl := "https://www.twitch.tv/yvraldis"
	Run, %turl%
}

OpenTwitter() {
	turl := "https://twitter.com/Yvraldis"
	Run, %turl%
}

ReadIni(k, s="Config", d="") {
	IniRead, v, %PathToMainINI%, %s%, %k%, %d%
	If (v = d)
		IniWrite, %d%, %PathToMainINI%, %s%, %k%
	Return %v%
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

ReadThemes() {
	arr := []
	tf := A_ScriptDir . "\Themes\*.*"
	Loop Files, %tf%, D
    	arr.Push(A_LoopFileName)
	Return arr
}

RefreshMenu(b=0) {
	Static a
	GetWebData("Twitch", "https://www.twitch.tv/yvraldis")
	GetWebData("Twitter", "https://rss.app/feeds/RlRJtcDm23osS3Dp.xml")
	GetWebData("Instagram", "https://rss.app/feeds/TFWPloYEDai0dx6r.xml")
	If isOnline() && !a {
		Menu, Tray, Tip, %AppTooltip%
		Menu, Tray, Enable, Web portals
		Menu, Tray, Enable, Etsy Store
		Menu, Tray, Enable, %TwitchTitle%
		Menu, Tray, Enable, %TwitterTitle%
		Menu, Tray, Enable, %InstagramTitle%
		a := true
	}
	If !isOnline() && (a || b) {
		Menu, Tray, Disable, Web portals
		Menu, Tray, Disable, Etsy Store
		Menu, Tray, Disable, %TwitchTitle%
		Menu, Tray, Disable, %TwitterTitle%
		Menu, Tray, Disable, %InstagramTitle%
		a := false
	}
}

rnd(from,to,set:=100) {
	FormatTime, t ,, HHmmss
	Random, , %t%
	Loop, set {
		Random, rand, 0, 999999
		Random, , %rand%
	}
	Random, rand, %from%, %to%
	Return rand
}

SaveIni(k, v, s="Settings") {
	IniWrite, %v%, %PathToMainINI%, %s%, %k%
}

SelectDDLitem(key, ddlarray, itemName) {
	GuiControl, menu: Choose, %key%, % GetSlotIdFromArray(ddlarray, itemName)
    GuiControlGet, itemName, menu:, %key%
	Return itemName
}

SelectDDLitemlist(key, ddlarray) {
	GuiControl, menu:, %key%, |
	GuiControl, menu:, %key%, % DDLbuilder(ddlarray)
}

selectRNDmeme(th) {
	rndt := rnd(1, CountMemes(th))
    tf := A_ScriptDir . "\Themes\" . th . "\configs\*.*"
	Loop Files, %tf%, F
	{
        If (rndt = A_Index) && A_LoopFileName {
	        SplitPath, A_LoopFileName , ,,,f
			Return f
		}
	}
}

selectRNDtheme() {
	rndt := rnd(1, CountThemes())
    tf := A_ScriptDir . "\Themes\*.*"
	Loop Files, %tf%, D
	{
        If (rndt = A_Index) && A_LoopFileName {
	        SplitPath, A_LoopFileName, ,,,f
			Return f
		}
	}
}

SplashScreen() {
  	Gui, Splash: Color, 1a2b3c
	Gui, Splash: +HwndSplashwdHwnd +LastFound +AlwaysOnTop -Caption +ToolWindow
	Gui, Splash: Add, Picture, x0 y0, %PathToSplashImage%
	Gui, Splash: Show, w%SplashPIC_widget_w% h%SplashPIC_widget_h% NA, Power Reminder Splash Screen
	WinSet, TransColor, 1a2b3c, ahk_id %SplashwdHwnd%
}

TrimRadiobox(Radiobox) {
	GuiControlGet, r, menu: Pos, %Radiobox%
	GuiControl, menu: Move, %Radiobox%, w%rH%
}

WatchDPad() {
    Critical
	POV := GetKeyState("JoyPOV")
	If not POV = -1  ; No angle.
	{
		If (POV > 31500 or POV < 4500)  ; Up
	    	GBM(GBBai[5])
		Else If POV between 13500 and 22500  ; Down
	    	GBM(GBBai[6])
		Else If POV between 22500 and 31500  ; Left
	    	GBM(GBBai[7])
		Else If POV between 4500 and 13500  ; Right
	    	GBM(GBBai[8])
	}
}

WM_MOUSEMOVE() {
	static CurrControl, PrevControl, _TT
	MouseGetPos,x,y, WindowUnderMounse,, 2
	WinGetTitle, wn, ahk_id %WindowUnderMounse%
	wa := StrSplit(wn, "|")
	wt := Trim(wa[1])
    WinCount := Trim(wa[2])
	If (wt == "Power Reminder Widget") {
		Gui, txtwd%WinCount%: destroy
		Gui, picwd%WinCount%: destroy
        LogEvent("Notifier: " . WinCount . " Closed by mouseover", NOTIFIERLOG)
	}

	CurrControl := A_GuiControl
	If (CurrControl <> PrevControl) {
			SetTimer, DisplayToolTip, -100
			PrevControl := CurrControl
	}
	return
	DisplayToolTip:
		Try
				ToolTip, % %CurrControl%_TT
		Catch
				ToolTip,
		SetTimer, RemoveToolTip, -2000
	return

	RemoveToolTip:
		ToolTip,
	return
}

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
		%s%_TT := ev
	}

	(Edit2_1 > 14400) ? Edit2_1 := 14400
	(Edit2_1 < 15) ? Edit2_1 := 15
	(Edit2_2 > 60000) ? Edit2_2 := 60000
	GuiControl, menu:, Slider2_1, %Edit2_1%
	GuiControl, menu:, Edit2_1, %Edit2_1%
	GuiControl, menu:, Slider2_2, %Edit2_2%
	GuiControl, menu:, Edit2_2, %Edit2_2%
	Slider2_1_TT := Edit2_1
	Slider2_2_TT := Edit2_2

	s := "GameBoy"
	Loop, 9 {
        b = Edit4_%A_index%
		b := %b%
		SaveIni(GBBa[A_Index], b, s)
		GBBai[A_Index] := b
	}
	GoTo, WriteSelection
Return

Exit:
	ExitApp
Return

GameBoyButton:
	hk := A_ThisHotkey
	(hk = "Joy1") ? GBM(GBBai[3])
	(hk = "Joy2") ? GBM(GBBai[4])
	(hk = "Joy7") ? GBM(GBBai[2])
	(hk = "Joy8") ? GBM(GBBai[1])
return

Menu:
	If (!Loaded)
		GoTo, menuGuiClose

	Global ThemeDropDownList := DDLbuilder(ReadThemes())
	Global MemeDropDownList := DDLbuilder(ReadMemes())
    If (MenuHwnd) {
		Gui, menu: destroy
        MenuHwnd := ""
		Return
	}
	Gui, menu: destroy
	Gui, menu: +LastFound +HwndMenuHwnd +E0x20
	Gui, menu: Font, s8 w100, Tahoma
	Gui, menu: Add, Button, Hidden w0 h0 Default, Save
	Gui, menu: Add, Tab, x0 y0 w%win_w% h%win_h% , Settings||Meme Timer|GameBoy Modus|Info|
	Gui, menu: Font, s8 w600, Tahoma

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
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_1 gWriteSelection x%column2% y%row2% w30 h20 ,
	Gui, menu: Add, Radio, vRadio1_2 gWriteSelection x%column3% y%row2% w30 h20 ,

	gby := row3 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_3 gWriteSelection x%column2% y%row3% w30 h20 ,
	Gui, menu: Add, Radio, vRadio1_4 gWriteSelection x%column3% y%row3% w30 h20 ,

	gby := row4 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_5 gWriteSelection x%column2% y%row4% w30 h20 ,
	Gui, menu: Add, Radio, vRadio1_6 gWriteSelection x%column3% y%row4% w30 h20 ,

	gby := row5 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_7 gWriteSelection x%column2% y%row5% w30 h20 ,
	Gui, menu: Add, Radio, vRadio1_8 gWriteSelection x%column3% y%row5% w30 h20 ,

	gby := row6 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_9 gWriteSelection x%column2% y%row6% w30 h20 ,
	Gui, menu: Add, Radio, vRadio1_10 gWriteSelection x%column3% y%row6% w30 h20 ,

	gby := row7 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
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
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_13 gWriteSelection x%column6% y%row2% w40 h20 ,
	Gui, menu: Add, Radio, vRadio1_14 gWriteSelection x%column7% y%row2% w40 h20 ,

	gby := row3 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_15 gWriteSelection x%column6% y%row3% w40 h20 ,
	Gui, menu: Add, Radio, vRadio1_16 gWriteSelection x%column7% y%row3% w40 h20 ,

	gby := row4 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_17 gWriteSelection x%column6% y%row4% w40 h20 ,
	Gui, menu: Add, Radio, vRadio1_18 gWriteSelection x%column7% y%row4% w40 h20 ,

	gby := row5 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_19 gWriteSelection x%column6% y%row5% w40 h20 ,
	Gui, menu: Add, Radio, vRadio1_20 gWriteSelection x%column7% y%row5% w40 h20 ,

	gby := row6 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_21 gWriteSelection x%column6% y%row6% w40 h20 ,
	Gui, menu: Add, Radio, vRadio1_22 gWriteSelection x%column7% y%row6% w40 h20 ,

	gby := row7 - 1
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio1_23 gWriteSelection x%column6% y%row7% w40 h20 ,
	Gui, menu: Add, Radio, vRadio1_24 gWriteSelection x%column7% y%row7% w40 h20 ,

	t := column8 + 10
	w := 150
	Gui, menu: Add, Text, x%t% y%row1% w115 h20 , Time
	Gui, menu: Add, Slider, AltSubmit vSlider1_1 gWriteSelectionSliderTimer range15-14400 x%column8% y%row2% w%w% h20 , 25
	Gui, menu: Add, Slider, AltSubmit vSlider1_2 gWriteSelectionSliderTimer range15-14400 x%column8% y%row3% w%w% h20 , 25
	Gui, menu: Add, Slider, AltSubmit vSlider1_3 gWriteSelectionSliderTimer range15-14400 x%column8% y%row4% w%w% h20 , 25
	Gui, menu: Add, Slider, AltSubmit vSlider1_4 gWriteSelectionSliderTimer range15-14400 x%column8% y%row5% w%w% h20 , 25
	Gui, menu: Add, Slider, AltSubmit vSlider1_5 gWriteSelectionSliderTimer range15-14400 x%column8% y%row6% w%w% h20 , 25
	Gui, menu: Add, Slider, AltSubmit vSlider1_6 gWriteSelectionSliderTimer range15-14400 x%column8% y%row7% w%w% h20 , 25

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
	column2 := 225
	column3 := 248
	column4 := 331
	column5 := 481

	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column2% y%row1% w60 h20 , On/Off
	t := column4 + 10
	Gui, menu: Add, Text, x%t% y%row1% w115 h20 , Time
	t := column5 + 26
	Gui, menu: Add, Text, x%t% y%row1% w14 h20 , s.

	gbx := column2 - 1
	gby := row2 - 1
	Gui, menu: Add, Text, x%column1% y%row2% w180 h20 , Energy Reminder
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio2_1 gWriteSelection x%column2% y%row2% w30 h20 ,
	Gui, menu: Add, Radio, vRadio2_2 gWriteSelection x%column3% y%row2% w30 h20 ,

	gby := row3 - 1
	w := 150
	Gui, menu: Add, Text, x%column1% y%row3% w180 h20 , Energy Reminder Pop-Ups
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio2_3 gWriteSelection x%column2% y%row3% w30 h20 ,
	Gui, menu: Add, Radio, vRadio2_4 gWriteSelection x%column3% y%row3% w30 h20 ,
	Gui, menu: Add, Slider, AltSubmit vSlider2_1 gWriteSelectionSlider2_1Settings range15-14400 x%column4% y%row3% w%w% h20 , 25
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit5 vEdit2_1 x%column5% y%row3% w40, 12345
	Gui, menu: Font, s8 w600

	gby := row4 - 1
	Gui, menu: Add, Text, x%column1% y%row4% w180 h20 , Idle Modus
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio2_5 gWriteSelection x%column2% y%row4% w30 h20 ,
	Gui, menu: Add, Radio, vRadio2_6 gWriteSelection x%column3% y%row4% w30 h20 ,

	gby := row5 - 1
	t := column5 + 18
	Gui, menu: Add, Text, x%t% y%row5% w20 h20 , ms.
	Gui, menu: Add, Text, x%column1% y%row5% w180 h20 , Meme Pop-Ups
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio2_7 gWriteSelection x%column2% y%row5% w30 h20 ,
	Gui, menu: Add, Radio, vRadio2_8 gWriteSelection x%column3% y%row5% w30 h20 ,

	Gui, menu: Add, Text, x%column1% y%row6% w180 h20 , Pop-Up Time
	Gui, menu: Add, Slider, AltSubmit vSlider2_2 gWriteSelectionSlider2_2Settings range1-60000 x%column4% y%row6% w%w% h20 , 3000
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit5 vEdit2_2 x%column5% y%row6% w40, %Popup_time%
	Gui, menu: Font, s8 w600

	gby := row7 - 1
	Gui, menu: Add, Text, x%column1% y%row7% w180 h20 , GameBoy Modus (Xbox Pad)
	Gui, menu: Add, GroupBox, x%gbx% y%gby% w25 h12,
	Gui, menu: Add, Radio, vRadio2_9 gWriteSelection x%column2% y%row7% w30 h20 ,
	Gui, menu: Add, Radio, vRadio2_10 gWriteSelection x%column3% y%row7% w30 h20 ,


	;------------------------------------------------------------- GameBoy Modus Tab
	Gui, menu: Tab, GameBoy Modus

	column1 := 32
	column2 := 92
	column3 := 290
	column4 := 330


	gby := row3 - 1
	w := 150
	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column1% y%row2% w80 h20 , Start
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_1 x%column2% y%row2% w140, yvraldStart
	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column3% y%row2% w80 h20 , Up
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_5 x%column4% y%row2% w140, yvraldUp

	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column1% y%row3% w80 h20 , Select
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_2 x%column2% y%row3% w140, yvraldSelect
	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column3% y%row3% w80 h20 , Down
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_6 x%column4% y%row3% w140, yvraldDown

	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column1% y%row4% w80 h20 , A Button
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_3 x%column2% y%row4% w140, yvraldKekfe
	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column3% y%row4% w80 h20 , Left
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_7 x%column4% y%row4% w140, yvraldLeft

	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column1% y%row5% w80 h20 , B Button
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_4 x%column2% y%row5% w140, yvraldTroll
	Gui, menu: Font, s8 w600
	Gui, menu: Add, Text, x%column3% y%row5% w80 h20 , Right
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_8 x%column4% y%row5% w140, yvraldRight
	Gui, menu: Font, s8 w600

	column3 := 170
	column4 := 220
	row6 += 5
	Gui, menu: Add, Text, x%column3% y%row6% w80 h20 , Spare
	Gui, menu: Font, s8 w100
	Gui, menu: Add, Edit, r1 limit15 vEdit4_9 x%column4% y%row6% w140, yvraldLoad
	Gui, menu: Font, s8 w600


	;---------------------------------------------------------------------- Info Tab
	Gui, menu: Tab, Info
	column1 := 12
	w := win_w - 15
	h := win_h - 20
	row0 := row1 - 15
	Gui, menu: Font, s8 w300, Courier New
	Gui, menu: Add, Text, gOpenGithub BackgroundTrans x%column1% y%row0% w%w% h%h% , %InfoText%

	Loop, 24
		TrimRadiobox("Radio1_" . A_Index)
	Loop, 10
		TrimRadiobox("Radio2_" . A_Index)

	Load_CFG_Radios()
	Load_CFG_DDL()
	Load_CFG_Edit()

	Gui, menu: Show, x622 y349 w%win_w% h%win_h%, %AppTitle%
Return

menuGuiClose:
	Gui, menu: Destroy
    MenuHwnd := ""
Return

OpenGithub:
	Run https://github.com/BNK3R-Boy/PowerReminder
Return

OpenTwitterLink:
	Run %TwitterLink%
Return

OpenInstagramLink:
	Run %InstagramLink%
Return

OpenYouTubeLink:
	Run %YouTubeLink%
Return

Reload:
	Reload
Return

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
	SaveIni("PopUpTime", Edit2_2, "Settings")
	SaveIni("EnergyReminderPopUps", Radio2_3, "Settings")
	SaveIni("Idle", Radio2_5, "Settings")
	SaveIni("MemePopUps", Radio2_7, "Settings")
	SaveIni("GamBoyMode", Radio2_9, "Settings")

	Popup_time := Edit2_2

	If (Radio2_5) {
        SetTimer, %fnEnRi%, off
        ClosePopUpGUIs("kill")
	}
	If (!ReadIni("onoff", "Settings")) {
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

WriteSelectionSliderTimer:
	Loop, 6 {
		e := "Edit1_" . A_Index
		s := "Slider1_" . A_Index
		sv := %s%
		GuiControl, menu:, %e%, %sv%
		SaveIni("Time", sv, "Timer" . A_Index)
	}
Return

WriteSelectionSlider2_1Settings:
	e := "Edit2_1"
	s := "Slider2_1"
	sv := %s%
	GuiControl, menu:, %e%, %sv%
	SaveIni("Time", sv, "Settings")
	%s%_TT := sv
Return

WriteSelectionSlider2_2Settings:
	e := "Edit2_2"
	s := "Slider2_2"
	sv := %s%
	GuiControl, menu:, %e%, %sv%
	SaveIni("PopUpTime", sv, "Settings")
	%s%_TT := sv
Return