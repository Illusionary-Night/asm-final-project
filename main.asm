INCLUDE Irvine32.inc
INCLUDE display.inc
INCLUDE graph.inc
INCLUDE GameDataType.inc

main EQU start@0

ExitProcess proto,dwExitCode:dword

.data
	teststr1 BYTE "*     *",
		      "       ",
		      "  ***  "
	teststr2 BYTE "game start", 0Dh, 0Ah
	rec1 RECTANGLE <>
	P1 PICTURE <>
	_title TEXT <>
	color WORD 0Ah
	Cursor COORD <3,3>
.code

main proc

	INVOKE Display_Init
	INVOKE SetText, OFFSET _title, OFFSET teststr2, 0Ah, Cursor, LENGTHOF teststr2
	INVOKE SetRectangle, OFFSET rec1, '*', 07h, 5, 3, Cursor
	INVOKE SetPicture, OFFSET P1, OFFSET teststr1, 07h, 7, 3, Cursor
	
	;INVOKE ShowPicture, OFFSET P1
	;INVOKE ErasePicture, OFFSET P1

	INVOKE ShowRectangle, OFFSET rec1
	;INVOKE EraseRectangle, OFFSET rec1

	;INVOKE ShowText, OFFSET _title
	;INVOKE EraseText, OFFSET _title
	call WaitMsg	

	invoke ExitProcess,0

main endp

end main
