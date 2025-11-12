INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/ToolInfo.inc
INCLUDE ./asm-final-project/DataType/Seller.inc

.data
	SellerToolBuf TOOL <>
	SellerCursor COORD <GOODSPOSITIONX,GOODSPOSITIONY>
	SellerStrBuf BYTE 10 DUP(0)
	RarityStr  	BYTE "Rarity: "
	CoolDownTimeStr BYTE "CoolDownTime: "
	TypeStr		BYTE "Type: "
	HpStr		BYTE "Hp: "
	EpStr		BYTE "Ep: "
	MpStr		BYTE "Mp: "
	ShieldStr	Byte "Shield: "
	TestText Text <>
	TS1 BYTE "There is TOOL"
	ToolIndex BYTE 0
.code

ShowGoods proc uses esi eax ecx Shelf: PTR GOODS

	mov esi, Shelf
	INVOKE ShowRectangle, esi

	add esi, SIZEOF RECTANGLE
	mov ecx, MAXGOODS
	
	SetSellerCursor GOODSPOSITIONX, GOODSPOSITIONY
	
	L1:
		mov eax, [esi]
		cmp eax, 0
		je L2
		;INVOKE ......, OFFSET SellerToolBuf, [esi]		
		INVOKE SetText, OFFSET TestText, OFFSET TS1, 0Ah, SellerCursor, LENGTHOF TS1
		INVOKE ShowText, OFFSET TestText
		
		L2:
			add esi, 4
			IncSellerCursorY
	LOOP L1

	ret 4

ShowGoods endp

EraseGoods proc uses esi Shelf: PTR GOODS

	mov esi, Shelf
	INVOKE EraseRectangle, esi
	add esi, SIZEOF RECTANGLE
	mov ecx, MAXGOODS

	SetSellerCursor GOODSPOSITIONX, GOODSPOSITIONY
	
	L1:
		mov eax, [esi]
		cmp eax, 0
		je L2
		;INVOKE ......, OFFSET SellerToolBuf, [esi]		
		INVOKE SetText, OFFSET TestText, OFFSET TS1, 0Ah, SellerCursor, LENGTHOF TS1
		INVOKE EraseText, OFFSET TestText
		
		L2:
			add esi, 4
			IncSellerCursorY
	LOOP L1

	ret 4

EraseGoods endp

InsertTool proc uses esi eax ebx Shelf: PTR GOODS, UUID: BYTE

	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, ToolIndex
	mov bl, TYPE DWORD	
	mul bl
	add esi, eax
	mov al, UUID
	
	mov [esi], al	

	mov al, ToolIndex
	inc al
	mov ToolIndex, al

	ret 8

InsertTool endp

DeletTool proc Shelf: PTR GOODS, Index: BYTE

	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, Index
	mov bl, TYPE DWORD	
	mul bl
	add esi, eax
	mov al, 0
	
	mov [esi], al	

	ret 8

DeletTool endp

ShowToolInfo proc uses eax esi edi ebx ecx Shelf: PTR GOODS, Index: BYTE

	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	mov eax, SIZEOF (GOODS PTR [esi]).UUID
	add esi, eax

	INVOKE ShowRectangle, esi
	add esi, SIZEOF RECTANGLE
	INVOKE ShowRectangle, esi

	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, Index
	mov bl, TYPE DWORD
	mul bl
	add esi, eax
	mov eax, [esi]

	INVOKE GetToolByUUID, OFFSET SellerToolBuf, eax 	
	xor eax, eax
	xor ebx, ebx
	mov ecx, SHAPESIZE

	SetSellerCursor SHAPEPOSITIONX, GOODSPOSITIONY

	mov eax, 0

	L1:
		push ecx
		mov ecx, SHAPESIZE
		mov esi, OFFSET SellerStrBuf	
		L2:
			mov bl, SellerToolBuf.SHAPE[eax]
			add bl, '0'
			mov [esi], bl

			inc eax
			inc esi		
		LOOP L2
		pop ecx
		INVOKE SetText, OFFSET TestText, OFFSET SellerStrBuf, 0Ah, SellerCursor, SHAPESIZE
		INVOKE ShowText, OFFSET TestText
		IncSellerCursorY
	LOOP L1

	mov esi, OFFSET SellerToolBuf
	xor eax, eax

	SetSellerCursor ATTRIBUTEPOSITIONX, GOODSPOSITIONY
	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, LENGTHOF RarityStr
	INVOKE ShowText, OFFSET TestText
	mov al, (TOOL PTR [esi]).RARITY
	call WriteInt
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET CoolDownTimeStr, 0Ah, SellerCursor, LENGTHOF CoolDownTimeStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).COOLDOWNMAX
	call WriteInt
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET TypeStr, 0Ah, SellerCursor, LENGTHOF TypeStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).TYPEID
	call WriteInt
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET HpStr, 0Ah, SellerCursor, LENGTHOF HpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.HP
	call WriteInt
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET EpStr, 0Ah, SellerCursor, LENGTHOF EpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.EP
	call WriteInt
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET MpStr, 0Ah, SellerCursor, LENGTHOF MpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.MP
	call WriteInt
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET ShieldStr, 0Ah, SellerCursor, LENGTHOF ShieldStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.SHIELD
	call WriteInt
	IncSellerCursorY	
	
	ret

ShowToolInfo endp

EraseToolInfo proc uses eax esi edi ebx ecx Shelf: PTR GOODS
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

	SetSellerCursor SHAPEPOSITIONX, GOODSPOSITIONY

	L1:
		INVOKE SetText, OFFSET TestText, OFFSET SellerStrBuf, 0Ah, SellerCursor, SHAPESIZE
		INVOKE EraseText, OFFSET TestText
		IncSellerCursorY
	LOOP L1

	xor eax, eax

	SetSellerCursor ATTRIBUTEPOSITIONX, GOODSPOSITIONY
	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
	INVOKE EraseText, OFFSET TestText
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
	INVOKE EraseText, OFFSET TestText
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
	INVOKE EraseText, OFFSET TestText
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
	INVOKE EraseText, OFFSET TestText
	IncSellerCursorY
	
	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
	INVOKE EraseText, OFFSET TestText
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
	INVOKE EraseText, OFFSET TestText
	IncSellerCursorY

	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
	INVOKE EraseText, OFFSET TestText
	IncSellerCursorY

	mov esi, Shelf
	INVOKE ShowGoods, esi
		
	ret
EraseToolInfo endp

BuyTool proc Shelf: PTR GOODS, Index: BYTE

BuyTool endp



end