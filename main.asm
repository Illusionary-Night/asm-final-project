INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/IO/StartScene.inc
INCLUDE ./asm-final-project/DataType/BackPack.inc

main EQU start@0

ExitProcess proto,dwExitCode:dword

.data
	teststr1 BYTE "  **  ",
		      " *  * ",
		      " *  * ",
		      "  **  ",
		      " **** ",
		      "  **  "
	teststr2 BYTE "game start", 0Dh, 0Ah
	rec1 RECTANGLE <>
	pic1 PICTURE <>
	Li1 LINE <>
	_title TEXT <>
	color WORD 0Ah
	Tool1 TOOLSLOT <>
	Cursor COORD <1,0>
.code

main proc

	INVOKE Display_Init
	INVOKE DrawBackpack , Cursor
	;INVOKE ShowTitle
	;INVOKE SetText, OFFSET _title, OFFSET teststr2, 0Ah, Cursor, LENGTHOF teststr2
	;INVOKE SetLine, OFFSET Li1, '*', 0Ah, 1, 10, Cursor
	;INVOKE SetRectangle, OFFSET rec1, '*', 07h, 5, 3, Cursor
	;INVOKE SetPicture, OFFSET pic1, OFFSET teststr1, 07h, 6, 6, Cursor
	;INVOKE SetToolSlot, OFFSET Tool1, OFFSET teststr1, 0Ah
	
	;INVOKE ShowToolSlot, OFFSET Tool1, Cursor
	;INVOKE EraseToolSlotPic, OFFSET Tool1
	;INVOKE EraseToolSlotFrame, OFFSET Tool1

	;INVOKE ShowPicture, OFFSET pic1
	;INVOKE ErasePicture, OFFSET pic

	;INVOKE ShowRectangle, OFFSET rec1
	;INVOKE EraseRectangle, OFFSET rec1

	;INVOKE ShowLine, OFFSET Li1
	;INVOKE EraseLine, OFFSET Li1

	;INVOKE ShowText, OFFSET _title
	;INVOKE EraseText, OFFSET _title

	;L1:
		;mov ecx, 0
	;loop L1
		
	call WaitMsg	
	
	invoke ExitProcess,0

main endp

end main
