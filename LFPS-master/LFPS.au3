#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <MsgBoxConstants.au3>
Opt("GUIOnEventMode", 1)
$Form1 = GUICreate("LFPS", 274, 90, 192, 124)
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
$ProcessorColorLbl = GUICtrlCreateLabel("    ", 8, 8, 16, 17)
$ProcessorLoadLbl = GUICtrlCreateLabel("Processor load: ", 32, 8, 190, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$RamColorLbl = GUICtrlCreateLabel("    ", 8, 32, 16, 17)
$RamLoadLbl = GUICtrlCreateLabel("Phys. RAM available: ", 32, 32, 192, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$VerdictLbl = GUICtrlCreateLabel("You shouldn't experience low FPS problems.", 1, 66, 269, 20, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)

While 1
	$memUsage = MemGetStats()[2]/1024
	GUICtrlSetData($RamLoadLbl, "Phys. RAM available: " & Round($memUsage) & " MB.")
	$cpuUsage = _GetCPUUsage()
	$total = 0
	For $i = 1 To $cpuUsage[0]
		$total = $total + $cpuUsage[$i] ;This may not be the most optimal solution, but hey. It works!
	Next
	$total = Abs($total / $cpuUsage[0])
	If $total > 0 Then
		GUICtrlSetData($ProcessorLoadLbl, "Processor Load: " & $total & "%.")
	EndIf
	; All the cases:
	; Low ram low processor, low ram med processor, low ram hi processor.
	; Med ram low processor, med ram med processor, med ram hi processor.
	; Hi ram low processor hi ram med processor, hi ram hi processor.
	
	;TODO: Fix colors
	
	If ($memUsage < 1024 And $total > 70) then ;memory <1 GB, processor load >70%, problems may occur.
		GUICtrlSetBkColor($RamColorLbl, 0xFF0000) ;Red color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xFF0000) ;Red color
		GUICtrlSetData($VerdictLbl, "Real problems will have place. Do not play!")
	ElseIf ($memUsage < 1024 And $total > 50 And $total < 70) then ;memory 1GB, processor load >50% <70%, game should be playable but problems may occur.
		GUICtrlSetBkColor($RamColorLbl, 0xFF0000) ;Red color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xFFFF00) ;Yellow color
		GUICtrlSetData($VerdictLbl, "Game should be playable, but be aware of lags!")
	ElseIf ($memUsage < 1024 And $total > 0 And $total < 50) then ;same as ^, but RAM is too low and problems may occur.
		GUICtrlSetBkColor($RamColorLbl, 0xFF0000) ;Red color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xC0DCC0) ;Moneygreen color
		GUICtrlSetData($VerdictLbl, "RAM Too low. Problems may have place.")
	ElseIf ($memUsage < 2600 And $total > 70) then ;memory <2.5 GB, processor load >70%, problems may occur.
		GUICtrlSetBkColor($RamColorLbl, 0xFFFF00) ;Yellow color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xFF0000) ;Red color
		GUICtrlSetData($VerdictLbl, "Processor ussage to high.")
	ElseIf ($memUsage < 2600 And $total > 50 And $total < 70) then ;memory 2.5GB, processor load >50% <70%, game should be playable.
		GUICtrlSetBkColor($RamColorLbl, 0xFFFF00) ;Yellow color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xFFFF00) ;Yellow colors
		GUICtrlSetData($VerdictLbl, "Game should be playable.")
	ElseIf ($memUsage < 2600 And $total > 0 And $total < 50) then ;same as ^, Game should work good
		GUICtrlSetBkColor($RamColorLbl, 0xFFFF00) ;Yellow color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xC0DCC0) ;Moneygreen color
		GUICtrlSetData($VerdictLbl, "Game will work OK.")
	ElseIf ($memUsage <> 4500 And $total > 70) then ;memory <4.5 GB, processor load >70%, too high processor load.
		GUICtrlSetBkColor($RamColorLbl, 0xC0DCC0) ;Moneygreen color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xFF0000) ;Red colors
		GUICtrlSetData($VerdictLbl, "Too high processor load.")
	ElseIf ($memUsage <> 4500 And $total > 50 And $total < 70) then ;memory 2.5GB, processor load >50% <70%, game should work good.
		GUICtrlSetBkColor($RamColorLbl, 0xC0DCC0) ;Moneygreen color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xFFFF00) ;Yellow color
		GUICtrlSetData($VerdictLbl, "Game should work.")
	ElseIf ($memUsage <> 4500 And $total > 0 And $total < 50) then ;same as ^, Game should work excellent.
		GUICtrlSetBkColor($RamColorLbl, 0xC0DCC0) ;Moneygreen color
		GUICtrlSetBkColor($ProcessorColorLbl, 0xC0DCC0) ;Moneygreen color
		GUICtrlSetData($VerdictLbl, "Game should work excellent.")
	Else 
	EndIf
	
	Sleep(500) ;Optimal refresh delay; we do not want processor to get hot because of us.
WEnd

Func SpecialEvents()
    Select
        Case @GUI_CtrlId = $GUI_EVENT_CLOSE
            GUIDelete()
            Exit
    EndSelect
EndFunc   ;==>SpecialEvents

Func _GetCPUUsage()
    Local Const $SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION = 8
    Local Const $SYSTEM_TIME_INFO = 3
    Local Const $tagS_SPPI = "int64 IdleTime;int64 KernelTime;int64 UserTime;int64 DpcTime;int64 InterruptTime;long InterruptCount"

    Local $CpuNum, $IdleOldArr[1],$IdleNewArr[1], $tmpStruct
    Local $timediff = 0, $starttime = 0
    Local $S_SYSTEM_TIME_INFORMATION, $S_SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION
    Local $RetArr[1]

    Local $S_SYSTEM_INFO = DllStructCreate("ushort dwOemId;short wProcessorArchitecture;dword dwPageSize;ptr lpMinimumApplicationAddress;" & _
    "ptr lpMaximumApplicationAddress;long_ptr dwActiveProcessorMask;dword dwNumberOfProcessors;dword dwProcessorType;dword dwAllocationGranularity;" & _
    "short wProcessorLevel;short wProcessorRevision")

    $err = DllCall("Kernel32.dll", "none", "GetSystemInfo", "ptr",DllStructGetPtr($S_SYSTEM_INFO))

    If @error Or Not IsArray($err) Then
        Return $RetArr[0] = -1
    Else
        $CpuNum = DllStructGetData($S_SYSTEM_INFO, "dwNumberOfProcessors")
        ReDim $RetArr[$CpuNum+1]
        $RetArr[0] = $CpuNum
    EndIf
    $S_SYSTEM_INFO = 0

    While 1
        $S_SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION = DllStructCreate($tagS_SPPI)
        $StructSize = DllStructGetSize($S_SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION)
        $S_SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION = DllStructCreate("byte puffer[" & $StructSize * $CpuNum & "]")
        $pointer = DllStructGetPtr($S_SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION)

        $err = DllCall("ntdll.dll", "int", "NtQuerySystemInformation", _
            "int", $SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION, _
            "ptr", DllStructGetPtr($S_SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION), _
            "int", DllStructGetSize($S_SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION), _
            "int", 0)

        If $err[0] Then
            Return $RetArr[0] = -2
        EndIf

        Local $S_SYSTEM_TIME_INFORMATION = DllStructCreate("int64;int64;int64;uint;int")
        $err = DllCall("ntdll.dll", "int", "NtQuerySystemInformation", _
            "int", $SYSTEM_TIME_INFO, _
            "ptr", DllStructGetPtr($S_SYSTEM_TIME_INFORMATION), _
            "int", DllStructGetSize($S_SYSTEM_TIME_INFORMATION), _
            "int", 0)

        If $err[0] Then
            Return $RetArr[0] = -3
        EndIf

        If $starttime = 0 Then
            ReDim $IdleOldArr[$CpuNum]
            For $i = 0 to $CpuNum -1
                $tmpStruct = DllStructCreate($tagS_SPPI, $Pointer + $i*$StructSize)
                $IdleOldArr[$i] = DllStructGetData($tmpStruct,"IdleTime")
            Next
            $starttime = DllStructGetData($S_SYSTEM_TIME_INFORMATION, 2)
            Sleep(100)
        Else
            ReDim $IdleNewArr[$CpuNum]
            For $i = 0 to $CpuNum -1
                $tmpStruct = DllStructCreate($tagS_SPPI, $Pointer + $i*$StructSize)
                $IdleNewArr[$i] = DllStructGetData($tmpStruct,"IdleTime")
            Next

            $timediff = DllStructGetData($S_SYSTEM_TIME_INFORMATION, 2) - $starttime

            For $i=0 to $CpuNum -1
                $RetArr[$i+1] = Round(100-(($IdleNewArr[$i] - $IdleOldArr[$i]) * 100 / $timediff))
            Next

            Return $RetArr
        EndIf

        $S_SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION = 0
        $S_SYSTEM_TIME_INFORMATION = 0
        $tmpStruct = 0
    WEnd
