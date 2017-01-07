#WinActivateForce
#SingleInstance ignore
#NoEnv
#Warn
#Persistent
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetKeyDelay, 750
SetFormat, Float, 04.0

FileInstall, [ENTER ICON PATH]\01.ico, %a_temp%\01.ico, 0

Menu, Tray, Icon, %a_temp%\01.ico, 1, 1

if not A_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}

Gui,Show, hide w0 h0,Safecracker
gui, destroy
Gui, Font, s36
Gui,Add,Text,x5 y5 w40 h50 Center vPinA,*
Gui,Add,Text,x45 y5 w40 h50 Center vPinB,*
Gui,Add,Text,x85 y5 w40 h50 Center vPinC,*
Gui,Add,Text,x125 y5 w40 h50 Center vPinD,*
Gui,Font,s8
Gui,Add,Progress,x170 y8 w8 h8 cRed -border vStatuscolor,100
Gui,Add,Text,x180 y5 w60 h15 Left vStatusbox,STOPPED
Gui,Add,Text,x170 y20 w60 h15,MAX:
Gui,Add,Text,x200 y20 w60 h15 Left vClock,00:00
Gui,Add,Progress,x170 y35 w60 h15 border vprogbar,0

Gui,Add,Progress,x5 y60 w50 h50 cGray vbox1,100
Gui,Add,Text,x27 y79 w10 h12 BackgroundTrans vnum1,1

Gui,Add,Progress,x60 y60 w50 h50 cGray vbox2,100
Gui,Add,Text,x82 y79 w10 h12 BackgroundTrans vnum2,2

Gui,Add,Progress,x115 y60 w50 h50 cGray vbox3,100
Gui,Add,Text,x137 y79 w10 h12 BackgroundTrans vnum3,3

Gui,Add,Text,x170 y60 w30 h15,Start:
Gui,Add,Edit,x200 y60 w30 h15 Limit4 Number vstartnum,0000
Gui,Add,Text,x170 y75 w30 h15,Stop:
Gui,Add,Edit,x200 y75 w30 h15 Limit4 Number vstopnum,9999
Gui,Add,Checkbox,x170 y90 w60 h13 vreverse,Reverse

Gui,Add,Progress,x5 y115 w50 h50 cGray vbox4,100
Gui,Add,Text,x27 y135 w10 h12 BackgroundTrans vnum4,4

Gui,Add,Progress,x60 y115 w50 h50 cGray vbox5,100
Gui,Add,Text,x82 y135 w10 h12 BackgroundTrans vnum5,5

Gui,Add,Progress,x115 y115 w50 h50 cGray vbox6,100
Gui,Add,Text,x137 y135 w10 h12 BackgroundTrans vnum6,6

Gui,Add,Button,x170 y115 w60 h160 gStartstop vStartstop Default, Start

Gui,Add,Progress,x5 y170 w50 h50 cGray vbox7,100
Gui,Add,Text,x27 y190 w10 h12 BackgroundTrans vnum7,7

Gui,Add,Progress,x60 y170 w50 h50 cGray vbox8,100
Gui,Add,Text,x82 y190 w10 h12 BackgroundTrans vnum8,8

Gui,Add,Progress,x115 y170 w50 h50 cGray vbox9,100
Gui,Add,Text,x137 y190 w10 h12 BackgroundTrans vnum9,9

Gui,Font,s6
Gui,Add,Text,x5 y247 w50 h50 vFooter,Made`nby`nCommanding
Gui,Font,s8

Gui,Add,Progress,x60 y225 w50 h50 cGray vbox0,100
Gui,Add,Text,x82 y245 w10 h12 BackgroundTrans vnum0,0

Gui,Add,Text,x115 y240 w50 h40 Center BackgroundTrans vwaiting,
Gui,Add,Text,x115 y255 w50 h12 Center BackgroundTrans vcountdown,

Gui,Show,x150 y150 w235 h280,Safecracker
Gui +AlwaysOnTop
return

Startstop:
	GuiControlGet, Action, , %A_GuiControl%
	GuiControl, , %A_GuiControl%, % (Action = "Start" ? "Stop" : "Start")
	If (Action = "Start")
	{
		WinActivate, ahk_exe ShooterGame.exe
		Winset, Top,, ahk_exe ShooterGame.exe
		Gui +AlwaysOnTop
		SetTimer, MainLoop, -1
		GuiControl,, Statusbox, WORKING
		GuiControl, +cGreen, Statuscolor
	}
	else {
		GuiControl,, Statusbox, STOPPED
		GuiControl, +cRed, Statuscolor
		GuiControl,, progbar, 0
	}
Return

MainLoop:
	Gui, Submit, NoHide
	pin := startnum
	While (Action = "Start" && pin != stopnum) {
		WinActivate, ahk_exe ShooterGame.exe
		Winset, Top,, ahk_exe ShooterGame.exe
		Gui +AlwaysOnTop
		GuiControl,, waiting,Entering PIN
		WinActivate, ahk_exe ShooterGame.exe
		sleep 1500
		StringSplit, pinnum, pin
		Send e
		GuiControl, +cBlue, box%pinnum1%
		sleep 100
		GuiControl, +cGray, box%pinnum1%
		GuiControl,, num%pinnum1%, %pinnum1%
		GuiControl,, PinA, %pinnum1%
		Send %pinnum1%

		GuiControl, +cBlue, box%pinnum2%
		sleep 100
		GuiControl, +cGray, box%pinnum2%
		GuiControl,, num%pinnum2%, %pinnum2%
		GuiControl,, PinB, %pinnum2%
		Send %pinnum2%

		GuiControl, +cBlue, box%pinnum3%
		sleep 100
		GuiControl, +cGray, box%pinnum3%
		GuiControl,, num%pinnum3%, %pinnum3%
		GuiControl,, PinC, %pinnum3%
		Send %pinnum3%

		GuiControl, +cBlue, box%pinnum4%
		sleep 100
		GuiControl, +cGray, box%pinnum4%
		GuiControl,, num%pinnum4%, %pinnum4%
		GuiControl,, PinD, %pinnum4%
		Send %pinnum4%

		GuiControl,, waiting,
		Sleep, 1500

		PixelSearch, colorX, colorY, 930, 130, 930, 130, 0x919100,16
		if !Errorlevel
		{
			GuiControl, +cGreen, box%pinnum1%
			GuiControl,, num%pinnum1%, %pinnum1%
			GuiControl,, PinA, %pinnum1%

			GuiControl, +cGreen, box%pinnum2%
			GuiControl,, num%pinnum2%, %pinnum2%
			GuiControl,, PinB, %pinnum2%

			GuiControl, +cGreen, box%pinnum3%
			GuiControl,, num%pinnum3%, %pinnum3%
			GuiControl,, PinC, %pinnum3%

			GuiControl, +cGreen, box%pinnum4%
			GuiControl,, num%pinnum4%, %pinnum4%
			GuiControl,, PinD, %pinnum4%

			GuiControl,, waiting,
			GuiControl, +cGreen, Statuscolor
			GuiControl,, Statusbox, SOLVED
			GuiControl,, startstop, Start
			GuiControl,, progbar, 100
			break
		}
		else {

			if (reverse && stopnum < startnum) {
				pin-=1.0
				difference := startnum - stopnum
				percent := 100/difference
			}
			else if reverse {
				pin-=1.0        
				difference := startnum
				percent := 100/startnum+1
			}
			else {
				pin+=1.0
				difference := stopnum - startnum
				percent := 100/difference
			}
			if (pin < 0000) {
				GuiControl, +cRed, Statuscolor
				GuiControl,, Statusbox, STOPPED
				GuiControl,, startstop, Start
				GuiControl,, progbar, 100
				break
			}

			time := (difference*25)/3600
			ETA := Round(time)
			GuiControl,, Clock, %ETA%h
			GuiControl,, progbar, +%percent%
			GuiControl,, waiting,Waiting...
			iteration := 20
			while (Action = "Start" && iteration > 0) {
				iteration-=1
				GuiControl,, countdown, %iteration%s
				sleep 1000
				GuiControl,, countdown,
			}
		}
		GuiControl,, waiting,	
	}
	if (pin = stopnum) {
		GuiControl,, waiting,Entering PIN
		SetKeyDelay, 750
		SetFormat, Float, 04.0
		sleep 1500
		StringSplit, pinnum, pin
	
		Send e
		GuiControl, +cBlue, box%pinnum1%
		sleep 100
		GuiControl, +cGray, box%pinnum1%
		GuiControl,, num%pinnum1%, %pinnum1%
		GuiControl,, PinA, %pinnum1%
		Send %pinnum1%

		GuiControl, +cBlue, box%pinnum2%
		sleep 100
		GuiControl, +cGray, box%pinnum2%
		GuiControl,, num%pinnum2%, %pinnum2%
		GuiControl,, PinB, %pinnum2%
		Send %pinnum2%

		GuiControl, +cBlue, box%pinnum3%
		sleep 100
		GuiControl, +cGray, box%pinnum3%
		GuiControl,, num%pinnum3%, %pinnum3%
		GuiControl,, PinC, %pinnum3%
		Send %pinnum3%

		GuiControl, +cBlue, box%pinnum4%
		sleep 100
		GuiControl, +cGray, box%pinnum4%
		GuiControl,, num%pinnum4%, %pinnum4%
		GuiControl,, PinD, %pinnum4%
		Send %pinnum4%
	    Sleep, 1500
		GuiControl,, waiting,
		PixelSearch, colorX, colorY, 930, 130, 930, 130, 0x919100,16
		if !Errorlevel
		{
			GuiControl, +cGreen, box%pinnum1%
			GuiControl,, num%pinnum1%, %pinnum1%
			GuiControl,, PinA, %pinnum1%

			GuiControl, +cGreen, box%pinnum2%
			GuiControl,, num%pinnum2%, %pinnum2%
			GuiControl,, PinB, %pinnum2%

			GuiControl, +cGreen, box%pinnum3%
			GuiControl,, num%pinnum3%, %pinnum3%
			GuiControl,, PinC, %pinnum3%

			GuiControl, +cGreen, box%pinnum4%
			GuiControl,, num%pinnum4%, %pinnum4%
			GuiControl,, PinD, %pinnum4%

			GuiControl, +cGreen, Statuscolor
			GuiControl,, Statusbox, SOLVED
			GuiControl,, startstop, Start
			GuiControl,, progbar, 100
		}
		else {
			GuiControl, +cRed, Statuscolor
			GuiControl,, Statusbox, STOPPED
			GuiControl,, startstop, Start
			GuiControl,, progbar, 100
		}
		
	}
return
GuiClose:
ExitApp