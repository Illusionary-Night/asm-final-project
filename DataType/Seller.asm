INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/ToolInfo.inc
INCLUDE ./asm-final-project/DataType/Seller.inc

.data
	SellerToolBuf TOOL <>		; Buffer to store selected tool data
	SellerCursor COORD <GOODSPOSITIONX,GOODSPOSITIONY>		; Cursor for seller UI
	SellerStrBuf BYTE 10 DUP(0)	; Temporary string buffer

	; Attribute labels
	RarityStr  	BYTE "Rarity: "
	PriceStr	BYTE "Price: "
	CoolDownTimeStr BYTE "CoolDownTime: "
	TypeStr		BYTE "Type: "
	HpStr		BYTE "Hp: "
	EpStr		BYTE "Sp: "
	MpStr		BYTE "Mp: "
	ShieldStr	Byte "Shield: "
	AllyDeltaStr	BYTE "Ally: "
	EnemyDeltaStr	BYTE "Enemy: "
	TestText Text <>			; Text object for rendering
	TS1 BYTE "There is TOOL"	; Placeholder erase text
.code

; ------------------------------------------------------------
; ShowGoods
; Display the goods frame and list all tools in the shelf
; ------------------------------------------------------------
ShowGoods proc uses esi edi eax ecx Shelf: PTR GOODS

	mov esi, Shelf
	INVOKE ShowRectangle, esi		; Draw main goods frame

	mov ecx, MAXGOODS
	
	mov esi, Shelf
	SetSellerCursor (GOODS PTR [esi]).Position.X, (GOODS PTR [esi]).Position.Y

	add esi, SIZEOF RECTANGLE		; Move to UUID array
	
	L1:
		mov eax, [esi]
		cmp eax, 0
		je L2						; Skip empty slot
		INVOKE GetToolByUUID, OFFSET SellerToolBuf, eax		; Load tool data
		;INVOKE SetText, OFFSET TestText, OFFSET SellerToolBuf.TOOLNAME, 0Ah, SellerCursor, LENGTHOF SellerToolBuf.TOOLNAME		; Get tool name
		;INVOKE ShowText, OFFSET TestText		; Show tool name
		
		;    o TOOLNAME   }
		lea edi, SellerToolBuf.TOOLNAME

		;  ] w TestText
		INVOKE SetText, OFFSET TestText, edi, 0Ah, SellerCursor, 20  ;  Υ  strlen    o u      
		INVOKE ShowText, OFFSET TestText
		L2:
			add esi, 4				; Next UUID
			AddSellerCursorY 1		; Move cursor down
	LOOP L1

	ret 4

ShowGoods endp

; ------------------------------------------------------------
; EraseGoods
; Clear goods frame and erase all displayed tool names
; ------------------------------------------------------------
EraseGoods proc uses esi ecx eax Shelf: PTR GOODS

	mov esi, Shelf
	INVOKE EraseRectangle, esi		; Remove goods frame
	mov ecx, MAXGOODS
	
	mov eax, 0
	SetSellerCursor (GOODS PTR [esi]).Position.X, (GOODS PTR [esi]).Position.Y
	
	L1:
		INVOKE SetText, OFFSET TestText, OFFSET TS1, 0Ah, SellerCursor, GOODSFRAMEWIDTH
		INVOKE EraseText, OFFSET TestText
		AddSellerCursorY 1
	LOOP L1

	ret 4

EraseGoods endp

; ------------------------------------------------------------
; InsertTool
; Insert a tool UUID into the first empty slot
; ------------------------------------------------------------
InsertTool proc uses esi eax ebx ecx Shelf: PTR GOODS, UUID: DWORD

	mov esi, Shelf
	mov ecx, MAXGOODS
	add esi, SIZEOF RECTANGLE		; Move to UUID array

	L1:
		mov eax, [esi]
		cmp eax, 0
		jne Dummy					; Slot occupied
		
		Done:
			mov eax, UUID			; Insert UUID
			mov [esi], eax
			mov ecx, 1				; Stop loop
		Dummy:
			add esi, SIZEOF DWORD
	LOOP L1
	ret

InsertTool endp

; ------------------------------------------------------------
; DeletTool
; Remove a tool from shelf by index and erase its display
; ------------------------------------------------------------
DeletTool proc uses esi eax ebx ecx Shelf: PTR GOODS, Index: BYTE	

	; Erase tool name on screen
	mov esi, Shelf
	SetSellerCursor (GOODS PTR [esi]).Position.X, (GOODS PTR [esi]).Position.Y
	movzx ebx, Index
	AddSellerCursorY bx
	INVOKE SetText, OFFSET TestText, OFFSET TS1, 0Ah, SellerCursor, GOODSFRAMEWIDTH
	INVOKE EraseText, OFFSET TestText

	; Clear UUID in data array
	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, Index
	mov bl, TYPE DWORD	
	mul bl
	add esi, eax
	mov eax, 0
	
	mov [esi], eax	

	ret

DeletTool endp

; ------------------------------------------------------------
; ResetAllToolInGoods
; Remove all tools from goods shelf
; ------------------------------------------------------------
ResetAllToolInGoods proc uses eax esi ecx Shelf: PTR GOODS
	
	mov ecx, MAXGOODS
	mov eax, 0
	L1:
		INVOKE DeletTool, Shelf, al
		inc al
	LOOP L1
	mov eax, 0
	mov esi, Shelf
	mov (GOODS PTR [esi]).ToolIndex, al		; Reset tool index
	ret

ResetAllToolInGoods endp

; ------------------------------------------------------------
; ShowToolInfo
; Display selected tool shape and attribute information
; ------------------------------------------------------------
ShowToolInfo proc uses eax esi edi ebx ecx Shelf: PTR GOODS, Index: BYTE

	; Show attribute & shape frames
	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	mov eax, SIZEOF (GOODS PTR [esi]).UUID
	add esi, eax

	INVOKE ShowRectangle, esi
	add esi, SIZEOF RECTANGLE
	INVOKE ShowRectangle, esi

	; Load tool data into buffer
	INVOKE TakeTool, Shelf, OFFSET SellerToolBuf, Index	
	xor eax, eax
	xor ebx, ebx

	; Draw tool shape
	mov ecx, SHAPESIZE
	mov esi, Shelf
	mov ax, (GOODS PTR [esi]).Position.X
	sub ax, SHAPESIZE
	dec ax
	SetSellerCursor ax, (GOODS PTR [esi]).Position.Y

	mov eax, 0

	L1:
		push ecx
		mov ecx, SHAPESIZE
		mov esi, OFFSET SellerStrBuf	
		L2:
			mov bl, SellerToolBuf.SHAPE[eax]
			mov [esi], bl

			inc eax
			inc esi		
		LOOP L2
		pop ecx
		INVOKE SetText, OFFSET TestText, OFFSET SellerStrBuf, 0Ah, SellerCursor, SHAPESIZE
		INVOKE ShowText, OFFSET TestText
		AddSellerCursorY 1
	LOOP L1

	mov esi, Shelf
	mov ax, (GOODS PTR [esi]).Position.X
	add ax, GOODSFRAMEWIDTH
	inc ax
	SetSellerCursor ax, (GOODS PTR [esi]).Position.Y

	mov esi, OFFSET SellerToolBuf
	xor eax, eax

	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, LENGTHOF RarityStr
	INVOKE ShowText, OFFSET TestText
	mov al, (TOOL PTR [esi]).RARITY
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET PriceStr, 0Ah, SellerCursor, LENGTHOF PriceStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).PRICE
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET CoolDownTimeStr, 0Ah, SellerCursor, LENGTHOF CoolDownTimeStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).COOLDOWNMAX
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET TypeStr, 0Ah, SellerCursor, LENGTHOF TypeStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).TYPEID
	call WriteInt
	AddSellerCursorY 1
	;ally delta---------------------------------------------
	INVOKE SetText, OFFSET TestText, OFFSET AllyDeltaStr, 0Ah, SellerCursor, LENGTHOF AllyDeltaStr
	INVOKE ShowText, OFFSET TestText
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET HpStr, 0Ah, SellerCursor, LENGTHOF HpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.HP
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET EpStr, 0Ah, SellerCursor, LENGTHOF EpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.EP
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET MpStr, 0Ah, SellerCursor, LENGTHOF MpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.MP
	call WriteInt
	AddSellerCursorY 1
	;enemy delta---------------------------------------------
	INVOKE SetText, OFFSET TestText, OFFSET EnemyDeltaStr, 0Ah, SellerCursor, LENGTHOF EnemyDeltaStr
	INVOKE ShowText, OFFSET TestText
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET HpStr, 0Ah, SellerCursor, LENGTHOF HpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ENEMYDELTA.HP
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET EpStr, 0Ah, SellerCursor, LENGTHOF EpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ENEMYDELTA.EP
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET MpStr, 0Ah, SellerCursor, LENGTHOF MpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ENEMYDELTA.MP
	call WriteInt
	AddSellerCursorY 1
	;-------------------------------------------------------------


	ret

ShowToolInfo endp

; ------------------------------------------------------------
; EraseToolInfo
; Clear tool information panel and redraw goods list
; ------------------------------------------------------------
EraseToolInfo proc uses eax esi edi ebx ecx Shelf: PTR GOODS

	; Erase attribute and shape frames
	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	mov eax, SIZEOF (GOODS PTR [esi]).UUID
	add esi, eax

	INVOKE EraseRectangle, esi

	add esi, SIZEOF RECTANGLE
	INVOKE EraseRectangle, esi

	xor eax, eax
	xor ebx, ebx
	mov ecx, SHAPESIZE

	mov esi, Shelf
	mov ax, (GOODS PTR [esi]).Position.X
	sub ax, SHAPESIZE
	dec ax
	SetSellerCursor ax, (GOODS PTR [esi]).Position.Y

	L1:
		INVOKE SetText, OFFSET TestText, OFFSET SellerStrBuf, 0Ah, SellerCursor, SHAPESIZE
		INVOKE EraseText, OFFSET TestText
		AddSellerCursorY 1
	LOOP L1

	xor eax, eax

	mov ax, (GOODS PTR [esi]).Position.X
	add ax, GOODSFRAMEWIDTH
	inc ax
	SetSellerCursor ax, (GOODS PTR [esi]).Position.Y

	mov ecx, ATTRIBUTEHIGHT
	
	L2:
		INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
		INVOKE EraseText, OFFSET TestText
		AddSellerCursorY 1
	LOOP L2

	mov esi, Shelf
	INVOKE ShowGoods, esi		; Redraw goods list
		
	ret
EraseToolInfo endp

; ------------------------------------------------------------
; BuyTool
; Remove tool from shelf and return its UUID in EAX
; ------------------------------------------------------------
BuyTool proc uses esi ecx ebx Shelf: PTR GOODS, Index: BYTE
	
	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, Index
	mov bl, TYPE DWORD	
	mul bl
	add esi, eax
	mov eax, [esi]			; Get UUID
	
	push eax
	INVOKE DeletTool, Shelf, Index		; Remove tool
	pop eax
	ret

BuyTool endp

; ------------------------------------------------------------
; TakeTool
; Copy tool data from shelf into target TOOL buffer
; ------------------------------------------------------------
TakeTool proc uses ecx eax esi ebx Shelf: PTR GOODS, TargetTool: PTR TOOL, Index: BYTE	

	xor eax, eax
	xor ebx, ebx
	mov esi, Shelf
	add esi, SIZEOF RECTANGLE

	movzx eax, Index
	mov bl, TYPE DWORD
	mul bl
	add esi, eax
	mov eax, [esi]		; Get UUID

	INVOKE GetToolByUUID, TargetTool, eax
	ret

TakeTool endp

end