SendMode "Input"
SetWorkingDir A_ScriptDir
SetTitleMatchMode "RegEx"

if (A_Args.Length < 2) {
    FileAppend "Too few arguments given", "*"
    exit
}

Operation := A_Args[1]
InstallFile := A_Args[2]

Run InstallFile
if (Operation = "uninstall") {
    WinWait "Npcap \d+[\.\d+]+ Uninstall", , 3
    if (WinExist) {
        BlockInput True
        Sleep 150
        WinActivate
        Send "{Enter}"
        BlockInput False
    }

    WinWait "Npcap \d+[\.\d+]+ Uninstall"," Uninstall was completed successfully", 30
    if (WinExist) {
        BlockInput True
        Sleep 150
        WinActivate
        Send "{Enter}"
        BlockInput False
    }
} else if (Operation = "install") {
    WinWait "Npcap [\d\.]+ Setup", , 1
    if WinExist("Npcap [\d\.]+ Setup", "already installed") {
        BlockInput True
        Sleep 150
        WinActivate
        Send "!y"
        BlockInput False
    }

    WinWait "Npcap [\d\.]+ Setup", , 1
    if WinExist("Npcap [\d\.]+ Setup") {
        BlockInput True
        Sleep 150
        WinActivate
        Send "{Enter}"
        Sleep 150
        Send "{Tab}"
        Sleep 50
        Send "{Space}"
        Sleep 50
        Send "{Enter}"
        BlockInput False
    } else {
        exit -1
    }
    WinWait "Npcap [\d\.]+ Setup", "Setup was completed successfully", 30
    if (WinExist) {
        BlockInput True
        Sleep 250
        WinActivate
        Send "{Enter}"
        Sleep 50
        Send "{Enter}"
        BlockInput False
    }
} else {
    FileAppend "Unsupported operation", "*"
    exit 1
}