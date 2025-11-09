INCLUDE Irvine32.inc
INCLUDE display.inc

.data
	writehandle DWORD ?
	readhandle  DWORD ?
	OutputCount DWORD ?                                          ;for debug
	Screen_info CONSOLE_SCREEN_BUFFER_INFO <>
	DisplayCursor COORD <0,0>
	WriteAttribute WORD ?
.code

Display_Init proc uses eax esi

	invoke GetStdHandle, STD_OUTPUT_HANDLE
	mov writehandle, eax

	invoke GetStdHandle, STD_INPUT_HANDLE
	mov readhandle, eax

	INVOKE GetConsoleScreenBufferInfo, writehandle, OFFSET Screen_info

	call clear_screen
	
	INVOKE SetCursor, DisplayCursor
	mov esi, [OFFSET Screen_info]
	mov ax, [esi+8]
	INVOKE SetColor, ax
	ret

Display_Init endp

clear_screen proc uses eax ecx esi

	sub esp, 2
	mov esi, OFFSET Screen_info
	mov ecx, [esi+2]
	mov esi, ebp
	mov al, 0Dh
	mov [esi-2], al
	mov al, 0Ah
	mov [esi-3], al
	sub esi, 3
	L1:
		INVOKE PrintStr, esi, 2
	loop L1
	add esp, 2
	ret	

clear_screen endp

GetColor proc uses ax esi ecx color: PTR WORD

	mov esi, color
	mov ax, WriteAttribute
	mov [esi], ax
	ret 4

GetColor endp

GetCursor proc uses esi eax position: PTR COORD

	INVOKE GetConsoleScreenBufferInfo, writehandle, OFFSET Screen_info
	mov esi, OFFSET Screen_info
	mov eax, [esi+4]
	mov DisplayCursor, eax

	mov esi, position
	mov eax, DisplayCursor
	mov [esi], eax
	ret 4

GetCursor endp

GetScreenSize proc uses eax esi position: PTR COORD

	mov esi, OFFSET Screen_info
	mov eax, [esi]
	mov esi, position
	mov [esi], eax
	ret 4
	
GetScreenSize endp

SetCursor proc uses eax ecx position: COORD
	
	mov eax, position
	mov DisplayCursor, eax
	INVOKE SetConsoleCursorPosition, writehandle, DisplayCursor
	ret 4    

SetCursor endp

SetColor proc uses ax ecx color: WORD

	mov ax, color
	mov WriteAttribute, ax 
	INVOKE SetConsoleTextAttribute, writehandle, WriteAttribute
	ret 4

SetColor endp

PrintStr proc uses eax ecx esi Source: PTR BYTE, StrSize: DWORD     ;I don't know why it will change ecx, so we need to uses ecx.QQ

	
	INVOKE WriteConsole, writehandle, Source, StrSize, OFFSET OutputCount, 0
	ret 8

PrintStr endp

end