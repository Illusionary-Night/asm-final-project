.NOLIST

TEXT STRUCT
	source DWORD ?  ;the address of string
	color WORD ?
	position COORD <>
	_length WORD ?
TEXT ENDS

RECTANGLE STRUCT
	elememt BYTE ?    ;the basic ASCII that form a RECTANGLE
	color WORD ?
	_width WORD ?
	_length WORD ? 
	position COORD <>
RECTANGLE ENDS

SetText PROTO,
	object: PTR TEXT,
	source: PTR BYTE,   ;the address of string
	color: WORD,
	position: COORD,
	_length: WORD

ShowText PROTO,
	object: PTR TEXT

EraseText PROTO,
	object: PTR TEXT