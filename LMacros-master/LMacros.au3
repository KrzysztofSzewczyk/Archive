; --- This file is part of LMacros (github.com/KrzysztofSzewczyk/LMacros). Please visit this site
; --- for more information. This file among others is under copyright. All rights reserved to 
; --- Krzysztof Szewczyk / Nebuchodonezzar and project contributors.

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <GuiconstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <WinAPIvkeysConstants.au3>
#include <SendMessage.au3>
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3>

Opt("TrayMenuMode", 1) ;We want tray. At least i do.

Opt("GUIOnEventMode", 1) ;Event mode -> on

Global Const $SC_DRAGMOVE = 0xF012 ;Need for window moving

$MainForm = GUICreate("", 224, 162, 786, 538, $WS_POPUP, $WS_EX_TOPMOST) ;This should have no title. And it has no title. Create gui
GUISetBkColor(0x000080)
$Tab1 = GUICtrlCreateTab(0, 0, 223, 161, BitOR($TCS_BOTTOM,$TCS_FLATBUTTONS))
$Hotkeys = GUICtrlCreateTabItem("Hotkeys")
$HotkeysBGLbl = GUICtrlCreateLabel("    ", -48, -27, 288, 177)
$Label1 = GUICtrlCreateLabel("F5 -", 8, 16, 22, 17)
$Label2 = GUICtrlCreateLabel("F6 -", 8, 40, 22, 17)
$Label3 = GUICtrlCreateLabel("F7 -", 8, 64, 22, 17)
$Label4 = GUICtrlCreateLabel("F8 -", 8, 88, 22, 17)
$Input1 = GUICtrlCreateInput("Dummy 1", 40, 16, 169, 21)
$Input2 = GUICtrlCreateInput("Dummy 2", 40, 40, 169, 21)
$Input3 = GUICtrlCreateInput("Dummy 3", 40, 64, 169, 21)
$Input4 = GUICtrlCreateInput("Dummy 4", 40, 88, 169, 21)
$About = GUICtrlCreateTabItem("About LMacros")
$AboutBGLbl = GUICtrlCreateLabel("    ", -44, -7, 272, 153)
$AboutEdit = GUICtrlCreateEdit("", 8, 8, 209, 89, BitOR($ES_CENTER,$ES_WANTRETURN))
GUICtrlSetData(-1, StringFormat("LMacros - a simple lightweight macro utility for LoL players. Made by Krzysztof Szewczyk / Nebuchodonezzar (EUNE nick). Please check out github repository and source code - github.com/KrzysztofSzewczyk/LMacros!"))
GUICtrlSetBkColor(-1, 0xBFCDDB)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button1 = GUICtrlCreateButton("Exit LMacros", 8, 104, 211, 25)
GUICtrlSetState(-1,$GUI_ENABLE)
GUICtrlSetOnEvent(-1, "enddit")
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW, $MainForm)
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND") ;Gui created!

Func enddit()
	TrayTip("LMacros", "LMacros v 1.1 deinitialized.", 5)
	Exit ;Button function. 
EndFunc

Func f5proc()
	Send ("{Enter}")
	Send (GUICtrlRead($Input1))
	Send ("{Enter}")
EndFunc

Func f6proc()
	Send ("{Enter}")
	Send (GUICtrlRead($Input2))
	Send ("{Enter}")
EndFunc

Func f7proc()
	Send ("{Enter}")
	Send (GUICtrlRead($Input3))
	Send ("{Enter}")
EndFunc

Func f8proc()
	Send ("{Enter}")
	Send (GUICtrlRead($Input4))
	Send ("{Enter}")
EndFunc

Func WM_COMMAND($hWinHandle, $iMsg, $wParam, $lParam)
	_SendMessage($MainForm, $WM_SYSCOMMAND, $SC_DRAGMOVE, 0)
EndFunc

TrayTip("LMacros", "LMacros v 1.1 initialized.", 5)

While 1
	If _WinAPI_GetAsyncKeyState ( $VK_F5 ) then
		f5proc()
		While _WinAPI_GetAsyncKeyState ( $VK_F5 ) <> 0
			Sleep(1)
		WEnd
	Elseif _WinAPI_GetAsyncKeyState ( $VK_F6 ) then
		f6proc()
		While _WinAPI_GetAsyncKeyState ( $VK_F6 ) <> 0
			Sleep(1)
		WEnd
	Elseif _WinAPI_GetAsyncKeyState ( $VK_F7 ) then
		f7proc()
		While _WinAPI_GetAsyncKeyState ( $VK_F7 ) <> 0
			Sleep(1)
		WEnd
	Elseif _WinAPI_GetAsyncKeyState ( $VK_F8 ) then
		f8proc()
		While _WinAPI_GetAsyncKeyState ( $VK_F8 ) <> 0
			Sleep(1)
		WEnd
	Endif
	Sleep(1)
WEnd

Exit
