#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
SetTitleMatchMode, RegEx

if (%0% < 2) {
	FileAppend, "Too few arguments given", *
	exit
}

operation = %1%
file = %2%

Run, %file%
if (operation = "uninstall")
{
	WinWait, Npcap \d+[\.\d+]+ Uninstall, , 3
	IfWinExist
	{
		BlockInput On
		Sleep 150
		WinActivate
		Send {Enter}
		BlockInput, Off
	}

	WinWait, Npcap \d+[\.\d+]+ Uninstall, Uninstall was completed successfully, 30
	IfWinExist
	{
		BlockInput On
		Sleep 150
		WinActivate
		Send {Enter}
		BlockInput Off
	}
} else if (operation = "install") {
	WinWait, Npcap [\d\.]+ Setup, , 1
	if WinExist("Npcap [\d\.]+ Setup", "already installed") {
		BlockInput On
		Sleep 150
		WinActivate
		Send !n
		BlockInput Off
		exit
	}

	if WinExist("Npcap [\d\.]+ Setup") {
		BlockInput On
		Sleep 150
		WinActivate
		Send {Enter}
		Sleep 150
		Send {Tab}
		Sleep 50
		Send {Space}
		Sleep 50
		Send {Enter}
		BlockInput, Off
	} else {
		exit -1
	}
	WinWait, Npcap [\d\.]+ Setup, Setup was completed successfully, 30
	IfWinExist
	{
		BlockInput, On
		Sleep 250
		WinActivate
		Send, {Enter}
		Sleep 50
		Send, {Enter}
		BlockInput, Off
	}
} else {
	FileAppend, "Unsupported operation", *
	exit 1
}