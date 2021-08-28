﻿QuickSplit()
{
;Gives us access to all the premiere pro shortcuts - handling them in one file makes it easy to change them.
#Include %A_WorkingDir%\Premiere Pro Shortcuts.ahk

SendMode Event
;Waits to make sure any previous hotkeys have been released
keywait, %A_PriorHotKey%


;Just in case we're not in Premiere Pro
if(WinActive("ahk_exe Adobe Premiere Pro.exe") = 0)
	goto qsEnd

;Sets up the coord modes, making sure our pixel distances are consistent
coordmode, pixel, Window
coordmode, mouse, Window
coordmode, Caret, Window

;Disables mouse and keyboard input to make sure the function runs properly
BlockInput, SendAndMouse
BlockInput, MouseMove
BlockInput, On

;Sets the keypress delay for Send/Sendinput commands to be zero.
;If typing in the preset name isn't consistent for you, increase this value.
SetKeyDelay, 0

;get original mouse pos
MouseGetPos, moX, moY

;get timeline position
ControlGetPos, cX, cY, cW, cH, DroverLord - Window Class49, ahk_class Premiere Pro

;find playhead
ImageSearch, iX, iY, cX, cY, cX + cW, cY + cH, Img/playhead.png

if(ErrorLevel == 1)
	goto qsEnd
if(ErrorLevel == 2)
	goto qsEnd

;move mouse to playhead
MouseMove, iX + 2, iY + 5, 0

;switch to razor tool
SendInput kbSelectionTool := "v"
;hold down shift to slice all
SendInput {Shift down}
;slice
MouseClick, left, , , 1
;switch back to select too
SendInput {Shift up}
SendInput %kbSelectionTool%

qsEnd:

;return mouse to start
MouseMove, moX, moY, 0

;Re-enables input
blockinput, MouseMoveOff 
BlockInput, off 

}