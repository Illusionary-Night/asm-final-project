.NOLIST

TEXT STRUCT
	Source   DWORD ?  ;the address of string
	Color    WORD ?
	Position COORD <>
	_Length  WORD ?
TEXT ENDS

LINE STRUCT
	Element    BYTE ?    ;the basic ASCII that form a LINE
	Color      WORD ?
	IsVertical BYTE ?
	_Length    WORD ?
	Position   COORD <>
LINE ENDS


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

SetLine PROTO,
	Object:     PTR LINE,
	Element:    BYTE,   ;the address of string
	Color:      WORD,
	IsVertical: BYTE,
	_Length:    WORD,
	Position:   COORD
	
ShowLine PROTO,
	Object: PTR LINE

EraseLine PROTO,
	Object: PTR LINE


SetRectangle PROTO,
	object: PTR RECTANGLE,
	element: BYTE,   
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