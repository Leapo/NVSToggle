;==============================================================================================
; 0 Set Defaults
;==============================================================================================
#NoTrayIcon
#SingleInstance ignore
#Persistent

INISection1 = NVSToggleInternal
AppVersionStatic = 11
CfgVersionStatic = 11

INISection2 = UserOptionsSurround
BezelCorrectionStatic = 128
SwapScreensStatic = 0
OrientationStatic = 0
TopologyStatic = 0
TaskbarFixStatic = 0

INISection3 = UserOptionsExtended
AccessoryDisplayStatic = 0

INISection4 = GlobalOptions
ShowStatusWindowStatic = 1
TimingModeStatic = 1

OnExit, ExitSub

;==============================================================================================
; 1 Write new configuration file
;==============================================================================================
IniRead, CfgVersionVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection1%, CfgVersion
	IF CfgVersionVar != %CfgVersionStatic%
	{
		FileRemoveDir, %programdata%\NVSToggle\, 1
		FileRemoveDir, %appdata%\NVSToggle\, 1
		FileCreateDir, %programdata%\NVSToggle
		
		IniWrite, %AppVersionStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection1%, AppVersion
		IniWrite, %CfgVersionStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection1%, CfgVersion
		IniWrite, %BezelCorrectionStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, BezelCorrection
		IniWrite, %SwapScreensStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, SwapScreens
		IniWrite, %OrientationStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, Orientation
		IniWrite, %TopologyStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, Topology
		IniWrite, %TaskbarFixStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, TaskbarFix
		IniWrite, %AccessoryDisplayStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection3%, AccessoryDisplay
		IniWrite, %ShowStatusWindowStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection4%, ShowStatusWindow
		IniWrite, %TimingModeStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection4%, TimingMode
		
		MsgNewCFG()
	}

;==============================================================================================
; 2 Read and validate configuration file
;==============================================================================================
IniRead, AppVersionVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection1%, AppVersion
	IF (AppVersionVar < AppVersionStatic)
		IniWrite, %AppVersionStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection1%, AppVersion

IniRead, BezelCorrectionVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, BezelCorrection
	IF (BezelCorrectionVar < 0) or (BezelCorrectionVar > 1024){
		IniWrite, %BezelCorrectionStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, BezelCorrection
		BezelCorrectionVar = %BezelCorrectionStatic%
	}
IniRead, SwapScreenVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, SwapScreens
	IF (SwapScreenVar < 0) or (SwapScreenVar > 5){
		IniWrite, %SwapScreensStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, SwapScreens
		SwapScreenVar = %SwapScreensStatic%
	}
IniRead, OrientationVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, Orientation
	IF (OrientationVar < 0) or (OrientationVar > 3){
		IniWrite, %OrientationStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, Orientation
		OrientationVar = %OrientationStatic%
	}
IniRead, TopologyVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, Topology
	IF (TopologyVar < 0) or (TopologyVar > 4){
		IniWrite, %TopologyStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, Topology
		TopologyVar = %TopologyStatic%
	}
IniRead, TaskbarFixVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, TaskbarFix
	IF (TaskbarFixVar < 0) or (TaskbarFixVar > 1){
		IniWrite, %TaskbarFixStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection2%, TaskbarFix
		TaskbarFixVar = %TaskbarFixStatic%
	}
IniRead, AccessoryDisplayVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection3%, AccessoryDisplay
	IF (AccessoryDisplayVar < 0) or (AccessoryDisplayVar > 1){
		IniWrite, %AccessoryDisplayStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection3%, AccessoryDisplay
		AccessoryDisplayVar = %AccessoryDisplayStatic%
	}
IniRead, ShowStatusWindowVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection4%, ShowStatusWindow
	IF (ShowStatusWindowVar < 0) or (ShowStatusWIndowVar > 1){
		IniWrite, %ShowStatusWindowStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection4%, ShowStatusWindow
		ShowStatusWindowVar = %ShowStatusWindowStatic%
	}
IniRead, TimingModeVar, %programdata%\NVSToggle\NVSToggle.ini, %INISection4%, TimingMode
	IF (TimingModeVar < 1) or (TimingModeVar > 3){
		IniWrite, %TimingModeStatic%, %programdata%\NVSToggle\NVSToggle.ini, %INISection4%, TimingMode
		TimingModeVar = %TimingModeStatic%
	}
	
;==============================================================================================
; 2a Configure Execution Timings
;==============================================================================================
;Default timings												; Default timings applied unconditionally to ensure timings are never null
	Sleep1 = 0
	Sleep2 = 500
	Sleep3 = 1000

IfEqual TimingModeVar, 2										; Adjusted timings for slow computers
{
	Sleep1 = 100
	Sleep2 = 1000
	Sleep3 = 1500
}

IfEqual TimingModeVar, 3										; Adjusted timings for very slow computers
{
	Sleep1 = 1500
	Sleep2 = 1500
	Sleep3 = 3000
}

;==============================================================================================
; 3 Determine current display state
;==============================================================================================
IF (OrientationVar = 1) or (OrientationVar = 3)
	AspectRatioVar = 0.8
Else
	AspectRatioVar = 3.6

IF (AspectRatioVar < A_ScreenWidth/A_ScreenHeight)
{
	ToggleVar = ToggleOff
	IfEqual, ShowStatusWindowVar, 1
		MsgSplash("Switching to extended mode...")
}

IF (AspectRatioVar >= A_ScreenWidth/A_ScreenHeight)
{
	ToggleVar = ToggleOn
	IfEqual, ShowStatusWindowVar, 1
		MsgSplash("Switching to surround mode...")
}

;==============================================================================================
; 4 Open NVIDIA Control Panel hidden
;==============================================================================================
Runwait, taskkill /im nvcplui.exe /f, , Hide						; Make sure the NVCPL isn't  already open before proceeding
SetTimer, NVWindowOpacity, 2								; Make sure NVCPL window is hidden as quickly as possible

Loop{
	Run "C:\Program Files\NVIDIA Corporation\Control Panel Client\nvcplui.exe"
	WinWait, NVIDIA Control Panel, , 15
		IF ErrorLevel
			Msg("Time", "401")
		
		SetTimer, NVWindowOpacity, Off
		CenterWindow(NVIDIA Control Panel)
		WinActivate

	Loop{
		IfWinExist, , Span &displays with Surround
		{
			Sleep, %Sleep3%
			ControlClick, Button4							; Span displays with surround checkbox
			Sleep, %Sleep2%
			ControlClick, Button7							; Apply button
			Goto, %ToggleVar%
		}

		IfWinExist, , Set PhysX Configuration					; The presence of this menu item indicates Surround is not supported
			Msg("Compat", "402")

		Sleep 100
		IF a_index > 20									; Assume control panel has loaded and the page needs to be switched
		{
			ControlClick, Static3								; Configure Surround link
			Sleep 1000
			Runwait, taskkill /im nvcplui.exe /f, , Hide
			Sleep 500
			Break
		}
	}
	
	IF a_index > 3
		Msg("Time", "403")
}

Msg("Error", "404")

;==============================================================================================
; 5 Toggle-off (switch to Extended Desktop mode)
;==============================================================================================
ToggleOff:
	Loop{
		IF (AspectRatioVar > A_ScreenWidth/A_ScreenHeight){
			Sleep 200
			Runwait %windir%\System32\DisplaySwitch.exe /extend
			
			IF (AccessoryDisplayVar = 1){						; Quick user-specific hack to swap around displays in Extended mode
				Sleep 1000
				WinActivate, NVIDIA Control Panel				; Reactivate window
				Sleep 200
				ControlClick, Static10						; Set up multiple displays link
				Sleep 2000
				WinMove, , , 0, 0, 1024, 768					; Move window on-screen and set specific size
				Sleep 200
				MouseClick, Left, 339, 320, 1, 1				; Uncheck 4th Monitor
				Sleep 1000
				MouseClickDrag, Left, 426, 520, 621, 520, 1		; Swap positions of left and center screens
				Sleep 1000
				WinMove, -4096, -4096
				Sleep 200
				ControlClick, Button2						; Apply Button
				Sleep 2000
				Runwait, taskkill /im nvcplui.exe /f, , Hide
				ExitApp
			}
			Sleep 500
			Runwait, taskkill /im nvcplui.exe /f, , Hide
			ExitApp
		}
		
		Sleep 100
		IF a_index > 150
			Msg("Time", "501")
	}

Msg("Error", "502")
	
;==============================================================================================
; 6 Toggle-on (switch to Surround mode)
;==============================================================================================
ToggleOn:
	SetTimer, NVWindowOpacity, 2							; Make sure NVCPL window is hidden as quickly as possible
	WinWait, NVIDIA Set Up Surround, , 15
		IF ErrorLevel
			Msg("Time", "601")
		
		SetTimer, NVWindowOpacity, Off
		WinMove, 0, 0
		WinActivate
	
		Sleep, %Sleep1%									; TIMING MODE 2+ Wait for the window to become ready

		IF (TopologyVar != 0){
			IF (TopologyVar = 1){
				ControlClick, ComboBox1	
				Send {PgUp}{enter}
			}
			IF (TopologyVar = 2){
				ControlClick, ComboBox1	
				Send {PgUp}{Down}{enter}
			}
			IF (TopologyVar = 3){
				ControlClick, ComboBox1	
				Send {PgDn}{Up}{enter}
			}
			IF (TopologyVar = 4){
				ControlClick, ComboBox1	
				Send {PgDn}{enter}
			}
		}
		
		IF (SwapScreenVar != 0){
			Sleep 200
			IF (SwapScreenVar = 1)							; 1 Swap left and right
				MouseClickDrag, Left, 300, 200, 700, 200, 1
			IF (SwapScreenVar = 2)							; 2 Swap left and center
				MouseClickDrag, Left, 300, 200, 520, 200, 1
			IF (SwapScreenVar = 3)							; 3 Swap right and center
				MouseClickDrag, Left, 550, 200, 330, 200, 1
			IF (SwapScreenVar = 4){							; 4 Wrap right to left
				MouseClickDrag, Left, 640, 200, 420, 200, 1
				Sleep 200
				MouseClickDrag, Left, 420, 200, 200, 200, 1
				}
			IF (SwapScreenVar = 5){							; 5 Wrap left to right
				MouseClickDrag, Left, 200, 200, 420, 200, 1
				Sleep 200
				MouseClickDrag, Left, 420, 200, 640, 200, 1
				}
			}
			
		IF (OrientationVar != 0){
			Sleep 200
			IF (OrientationVar = 1){
				MouseClick, Right, 330, 145, 1, 1
				MouseClick, Left, 343, 180, 1, 1
				}
			IF (OrientationVar = 2){
				MouseClick, Right, 330, 145, 1, 1
				MouseClick, Left, 343, 203, 1, 1
				}
			IF (OrientationVar = 3){
				MouseClick, Right, 330, 145, 1, 1
				MouseClick, Left, 343, 224, 1, 1
				}
		}
		
		Sleep 200
		ControlClick, Edit1									; Bezel Correction Value
		Sleep, %Sleep1%									; TIMING MODE 2+ Wait for the window to become ready
		Send %BezelCorrectionVar%{Delete}{enter}

	Loop{
		IF (AspectRatioVar < A_ScreenWidth/A_ScreenHeight)
		{
			IfEqual, TaskbarFixVar, 1
			{
				WinClose, NVIDIA Set Up Surround
				MsgSplash("Applying window maximization fix...")	; Update splash window
				WinWaitClose
					
				WinActivate, NVIDIA Control Panel
				Sleep 500
				Loop, 2									; Fix for windows maximizing behind the taskbar
				{
					Sleep 200
					Send {Alt}
					Sleep 100
					Send k
					Sleep 100
					Send s
					Sleep 100
					Send c
				}
			}
			Sleep 200
			Runwait, taskkill /im nvcplui.exe /f, , Hide
			ExitApp
		}
		
		Sleep, 100
		IF a_index > 320
			Msg("Time", "602")
	}

Msg("Error", "603")

;==============================================================================================
; 7 Functions
;==============================================================================================
MsgNewCFG(){
	MsgBox, 323, Nvidia Surround Toggle, A new config file has been created in the following location:`n"%programdata%\NVSToggle\NVSToggle.ini"`n`nWould you like to edit these settings now?
		IfMsgBox Cancel
			ExitApp
		IfMsgBox Yes
			RunWait %windir%\System32\Notepad.exe %programdata%\NVSToggle\NVSToggle.ini
	Return
}

Msg(MsgString, ErrCode){
	Run, taskkill /im nvcplui.exe /f, , Hide
	SplashTextOff
	IfEqual, MsgString, Compat
		MsgBox, 64, Nvidia Surround Toggle, Attention: `nYour system is not NVIDIA Surround capable.
	IfEqual, MsgString, Error
		MsgBox, 16, Nvidia Surround Toggle, Error: `nExecution halted unexpectedly. (Code %ErrCode%)
	IfEqual, MsgString, Time
	{
		MsgBox, 16, Nvidia Surround Toggle, Error: `nTimed out while waiting for the NVIDIA Control Panel. (Code %ErrCode%)
		IfEqual, TimingModeVar, 1
			IniWrite, 2, %programdata%\NVSToggle\NVSToggle.ini, %INISection4%, TimingMode
		IfEqual, TimingModeVar, 2
			IniWrite, 3, %programdata%\NVSToggle\NVSToggle.ini, %INISection4%, TimingMode
	}
	ExitApp
}

MsgSplash(SimpleText){
	SplashTextOn, 320, 68, NVIDIA Surround Toggle, `n%SimpleText%
	WinSet, AlwaysOnTop, On, NVIDIA Surround Toggle
}

CenterWindow(WinTitle){
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}

;==============================================================================================
; 8 Async Timers
;==============================================================================================
NVWindowOpacity:
	WinSet, Transparent, 1, NVIDIA Control Panel
	WinSet, Transparent, 1, NVIDIA Set Up Surround
Return

ExitSub:
	Run, taskkill /im nvcplui.exe /f, , Hide
	SplashTextOff
	ExitApp
Return

;==============================================================================================
;9 Hotkeys
;==============================================================================================
Esc::Msg("Error", "901")