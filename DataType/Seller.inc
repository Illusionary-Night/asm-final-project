.NOLIST

IFNDEF __Seller
__Seller EQU 1

; --- Constants & UI Configuration ---
MAXGOODS           EQU 20			; Max items in shop
GOODSFRAMECOLOR    EQU 04h			; Color (Red)
GOODSFRAMEELEMENT  EQU '*'			; Border character

; Main List Dimensions
GOODSFRAMEWIDTH    EQU 18
GOODSFRAMEHIGHT    EQU MAXGOODS
GOODSPOSITIONX     EQU 140
GOODSPOSITIONY     EQU 5

OURGOODSPOSITIONX     EQU 90
OURSHAPEPOSITIONX     EQU OURGOODSPOSITIONX-SHAPESIZE-1
OURATTRIBUTEPOSITIONX EQU OURGOODSPOSITIONX+GOODSFRAMEWIDTH+2-1

; Item Detail Panel Dimensions
SHAPESIZE          EQU 4
ATTRIBUTEWIDTH     EQU 20
ATTRIBUTEHIGHT     EQU 12
SHAPEPOSITIONX     EQU GOODSPOSITIONX-SHAPESIZE-1
ATTRIBUTEPOSITIONX EQU GOODSPOSITIONX+GOODSFRAMEWIDTH+2-1
ATTRIBUTENUM       EQU 7

; --- Macros ---
; Sets cursor for text rendering in the shop UI
SetSellerCursor macro NEWX, NEWY
	push eax

	mov ax, NEWX
	inc ax
	mov SellerCursor.X, ax

	mov ax, NEWY
	inc ax
	mov SellerCursor.Y, ax

	pop eax
endm

; Moves cursor down by 'num' lines
AddSellerCursorY macro num
	push eax
	
	mov ax, SellerCursor.Y
	add ax, num
	mov SellerCursor.Y, ax

	pop eax
endm

; --- Data Structure ---
GOODS STRUCT
	MainFrame         RECTANGLE <GOODSFRAMEELEMENT,GOODSFRAMECOLOR,GOODSFRAMEWIDTH+2,GOODSFRAMEHIGHT+2,<GOODSPOSITIONX,GOODSPOSITIONY>>	
	UUID              DWORD MAXGOODS DUP(0)
	AttributeFrame    RECTANGLE <GOODSFRAMEELEMENT,GOODSFRAMECOLOR,ATTRIBUTEWIDTH+2,ATTRIBUTEHIGHT+2,<ATTRIBUTEPOSITIONX,GOODSPOSITIONY>>
	ShapeFrame        RECTANGLE <GOODSFRAMEELEMENT,GOODSFRAMECOLOR,SHAPESIZE+2,SHAPESIZE+2,<SHAPEPOSITIONX,GOODSPOSITIONY>>
	Position          COORD <GOODSPOSITIONX,GOODSPOSITIONY>
	ToolIndex         BYTE 0
GOODS ENDS

; --- Prototypes ---

ShowGoods PROTO,			; Display the goods list and UI frames
	Shelf: PTR GOODS

EraseGoods PROTO,			; Clear the goods list and UI from screen
	Shelf: PTR GOODS

InsertTool PROTO,			; Insert a tool into the goods shelf
	Shelf: PTR GOODS,
	UUID: DWORD

DeletTool PROTO,			; Remove a tool from the shelf by index
	Shelf: PTR GOODS,
	Index: BYTE

ResetAllToolInGoods PROTO,	; Clear all tools in the goods shelf
	Shelf: PTR GOODS

ShowToolInfo PROTO,			; Show detailed information of a tool
	Shelf: PTR GOODS,
	Index: BYTE

EraseToolInfo PROTO,		; Erase tool detail panel
	Shelf: PTR GOODS

							; Buy tool and return its UUID in EAX
BuyTool PROTO,            ;this function will return UUID in eax
	Shelf: PTR GOODS,
	Index: BYTE

TakeTool PROTO,				; Move tool from goods shelf to target TOOL
	Shelf: PTR GOODS,
	TargetTool: PTR TOOL,
	Index: BYTE	

ENDIF