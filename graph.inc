.NOLIST

TEXT STRUCT
	Source   DWORD ?  ;the address of string
	Color    WORD ?
	Position COORD <>
	_Length  WORD ?
TEXT ENDS

RECTANGLE STRUCT
	Element  BYTE ?    ;the basic ASCII that form a RECTANGLE
	Color    WORD ?
	_Width   WORD ?
	_Hight   WORD ? 
	Position COORD <>
RECTANGLE ENDS

PICTURE STRUCT
	Source   DWORD ?
	Color    WORD ?
	_Width   WORD ?
	_Hight   WORD ?
	Position COORD <>
PICTURE ENDS

SetText PROTO,
	Object:   PTR TEXT,
	Source:   PTR BYTE,   ;the address of string
	Color:    WORD,
	Position: COORD,
	_Length:  WORD

ShowText PROTO,
	object: PTR TEXT

EraseText PROTO,
	object: PTR TEXT

SetRectangle PROTO,
	object: PTR RECTANGLE,
	element: BYTE,   ;the address of string
	color: WORD,
	_width: WORD,
	_Hight: WORD,
	position: COORD

ShowRectangle PROTO,
	object: PTR RECTANGLE

EraseRectangle PROTO,
	object: PTR RECTANGLE

SetPicture PROTO,
	Object: PTR PICTURE,
	Source: PTR BYTE,   ;the address of string
	Color: WORD,
	_width: WORD,
	_Hight: WORD,
	Position: COORD

ShowPicture PROTO,
	object: PTR PICTURE

ErasePicture PROTO,
	object: PTR PICTURE