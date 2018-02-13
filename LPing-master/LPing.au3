#cs
MIT License

Copyright (c) 2017 Krzysztof Szewczyk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#ce

#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <MsgBoxConstants.au3>
Opt("GUIOnEventMode", 1)
$Form1 = GUICreate("LPing", 315, 188, 192, 147, $GUI_SS_DEFAULT_GUI)
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
$ServerLabel = GUICtrlCreateCombo("Pick a server...", 0, 0, 313, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "216.52.241.254 - NA|104.160.141.3 - EUW|104.160.142.3 - EUNE|104.160.156.1 - OCE|104.160.136.3 - LAN")
$LatencyLabel = GUICtrlCreateLabel("Latency: 0000 ms", 0, 24, 312, 17, $SS_CENTER)
$ShallIPlayLabel = GUICtrlCreateLabel("You can play safetly.", 112, 48, 102, 17, $SS_CENTER)
GUICtrlSetColor(-1, 0x008000)
$StatusLabel = GUICtrlCreateLabel("     ", 88, 48, 19, 17)
$Edit1 = GUICtrlCreateEdit("", 0, 72, 313, 113, BitOR($ES_CENTER,$ES_READONLY,$ES_WANTRETURN))
GUICtrlSetData(-1, StringFormat("Cool utility made by Krzysztof Szewczyk / \r\nNebuchodonezzar (EUNE nick).\r\nCreated to help LoL players to decide shall they \r\nplay, or not."))
GUICtrlSetFont(-1, 11, 400, 0, "Times New Roman")
GUICtrlSetColor(-1, 0x800000)
GUISetState(@SW_SHOW)

Func SpecialEvents()
    Select
        Case @GUI_CtrlId = $GUI_EVENT_CLOSE
            GUIDelete()
            Exit
    EndSelect
EndFunc   ;==>SpecialEvents

While 1
	If _GUICtrlComboBox_GetCurSel($ServerLabel) == 1 Then
		;NA
		Local $iPing = Ping("216.52.241.254", 250)
		If ($iPing <= 100 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xC0DCC0) ;Moneygreen color
			GUICtrlSetData($ShallIPlayLabel, "You can play safetly.")
		ElseIf ($iPing <= 350 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFFFF00) ;Yellow color
			GUICtrlSetData($ShallIPlayLabel, "Be aware of lags!")
		ElseIf ($iPing <= 65536 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFF0000) ;Red color
			GUICtrlSetData($ShallIPlayLabel, "You shouldn't play.")
		EndIf
	EndIf
	If _GUICtrlComboBox_GetCurSel($ServerLabel) == 2 Then
		;EUW
		Local $iPing = Ping("104.160.141.3", 250)
		If ($iPing <= 100 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xC0DCC0) ;Moneygreen color
			GUICtrlSetData($ShallIPlayLabel, "You can play safetly.")
		ElseIf ($iPing <= 350 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFFFF00) ;Yellow color
			GUICtrlSetData($ShallIPlayLabel, "Be aware of lags!")
		ElseIf ($iPing <= 65536 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFF0000) ;Red color
			GUICtrlSetData($ShallIPlayLabel, "You shouldn't play.")
		EndIf
	EndIf
	If _GUICtrlComboBox_GetCurSel($ServerLabel) == 3 Then
		;EUNE
		Local $iPing = Ping("104.160.142.3", 250)
		If ($iPing <= 100 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xC0DCC0) ;Moneygreen color
			GUICtrlSetData($ShallIPlayLabel, "You can play safetly.")
		ElseIf ($iPing <= 350 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFFFF00) ;Yellow color
			GUICtrlSetData($ShallIPlayLabel, "Be aware of lags!")
		ElseIf ($iPing <= 65536 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFF0000) ;Red color
			GUICtrlSetData($ShallIPlayLabel, "You shouldn't play.")
		EndIf
	EndIf
	If _GUICtrlComboBox_GetCurSel($ServerLabel) == 4 Then
		;OCE
		Local $iPing = Ping("104.160.156.1", 250)
		If ($iPing <= 100 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xC0DCC0) ;Moneygreen color
			GUICtrlSetData($ShallIPlayLabel, "You can play safetly.")
		ElseIf ($iPing <= 350 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFFFF00) ;Yellow color
			GUICtrlSetData($ShallIPlayLabel, "Be aware of lags!")
		ElseIf ($iPing <= 65536 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFF0000) ;Red color
			GUICtrlSetData($ShallIPlayLabel, "You shouldn't play.")
		EndIf
	EndIf
	If _GUICtrlComboBox_GetCurSel($ServerLabel) == 5 Then
		;LAN
		Local $iPing = Ping("104.160.136.3", 250)
		If ($iPing <= 100 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xC0DCC0) ;Moneygreen color
			GUICtrlSetData($ShallIPlayLabel, "You can play safetly.")
		ElseIf ($iPing <= 350 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFFFF00) ;Yellow color
			GUICtrlSetData($ShallIPlayLabel, "Be aware of lags!")
		ElseIf ($iPing <= 65536 And $iPing > 5) Then
			GUICtrlSetData($LatencyLabel, "Latency: " & $iPing & " ms")
			GUICtrlSetBkColor($StatusLabel, 0xFF0000) ;Red color
			GUICtrlSetData($ShallIPlayLabel, "You shouldn't play.")
		EndIf
	EndIf
	Sleep(500) ;Rito servers are just servers! Give them a bit of mercy (even if Veigar wont give me it)!
WEnd

