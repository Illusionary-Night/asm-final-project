.NOLIST

Display_Init PROTO

clear_screen PROTO

GetColor PROTO,         
	color: PTR WORD

GetCursor PROTO,        
	position: PTR COORD

GetScreenSize PROTO,
	position: PTR COORD

SetCursor PROTO,
	position: COORD 

SetColor PROTO,
	color: WORD

PrintStr PROTO,
	Source:PTR BYTE,      ;the address of string
	StrSize:DWORD
