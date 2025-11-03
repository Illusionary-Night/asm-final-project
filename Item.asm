INCLUDE Irvine32.inc
INCLUDE display.inc
INCLUDE graph.inc

main EQU start@0

ExitProcess proto,dwExitCode:dword

.data
	teststr1 BYTE "    ", 0Dh, 0Ah
	teststr2 BYTE "game start", 0Dh, 0Ah
	_title TEXT <>
	color WORD 0Ah
	Cursor COORD <3,3>
.code

main proc

	INVOKE Display_Init
	INVOKE SetText, OFFSET _title, OFFSET teststr2, 0Ah, Cursor, LENGTHOF teststr2
	INVOKE ShowText, OFFSET _title
	;INVOKE EraseText, OFFSET _title
	call WaitMsg	

	invoke ExitProcess,0

main endp

end main
